package com.company.daex.web.rpdfile;

import com.company.daex.entity.*;
import com.haulmont.bali.util.ParamsMap;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.*;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.components.*;
import com.haulmont.cuba.gui.components.actions.AddAction;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.export.ExportDisplay;
import com.haulmont.cuba.gui.export.ExportFormat;
import com.haulmont.cuba.gui.upload.FileUploadingAPI;
import com.company.daex.service.ExpertiseService;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class RPDFileEdit extends AbstractEditor<RPDFile> {

    //
    @Inject
    private Metadata metadata;
    @Inject
    private DataManager dataManager;
    @Inject
    private ExpertiseService service;

    //DataSource
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> filesDs;
    @Inject
    private CollectionDatasource<RemarkAnswer, UUID> remarkAnswersDs;

    //MultiFIleUpload
    @Inject
    private FileUploadingAPI fileUploadingAPI;
    @Inject
    private DataSupplier dataSupplier;
    @Inject
    private ExportDisplay exportDisplay;

    //Items
    @Inject
    private Table filesTable;

    @Inject
    private Button buttonFinalVersion;

    @Inject
    private FileMultiUploadField multiUpload;
    @Inject
    private Button buttonUnload;
    @Inject
    private Button buttonAddFile;
    @Inject
    private Button buttonRemoveFile;

    @Inject
    private Button butttonCreateRA;
    @Inject
    private Button butttonEditRA;

    @Named("filesTable.add")
    private AddAction add;
    
    private  RPDFile Class;//Доступ к обектам класса
    private List<String> Customers;
    //private FileDescriptor file;

    //Method
    protected void initNewItem(RPDFile item) {
        item.setFiles(new ArrayList<>());
    }

    @Override
    public void init(Map<String, Object> params) {
        Class = null;
        Customers = new ArrayList<>();

        //add.setWindowId("daex$IncomingDocumentFileDescriptor.browse");
    }

    @Override
    public void ready()
    {


        ///
        LoadContext<Expertise> LContextExpertise = LoadContext.create(Expertise.class);
        LContextExpertise.setView(View.BASE);//"accessSettings-view_1"

        LContextExpertise.setQueryString("SELECT e FROM daex$Expertise e" +
                " JOIN daex$RPD rpd ON rpd.expertiseRPD.id = e.id" +//)
                //" JOIN e.expertiseAccessSettings.id = exp.id" +
                " WHERE rpd.id = :id")
                .setParameter("id", getItem().getRpd().getUuid());


        Expertise expertise = dataManager.load(LContextExpertise);
/*
        ///
        LoadContext<AccessSettings> LContextAccessSettings2 = LoadContext.create(AccessSettings.class);
        LContextAccessSettings2.setView(View.BASE);//"accessSettings-view_1"

        LContextAccessSettings2.setQueryString("SELECT e FROM daex$AccessSettings e" +
                " JOIN daex$Expertise exp ON exp = e.expertiseAccessSettings" +
                " JOIN daex$RPD rpd ON rpd.expertiseRPD = exp" +//3
                //" JOIN e.expertiseAccessSettings.id = exp.id" +
                " WHERE rpd.id = :id")// +//1
                //" AND e.employee IS NULL")
                .setParameter("id", getItem().getRpd().getUuid());


        List<AccessSettings> list2 = dataManager.loadList(LContextAccessSettings2);
*/
        ///
        LoadContext<AccessSettings> LContextAccessSettings = LoadContext.create(AccessSettings.class);
        LContextAccessSettings.setView(View.BASE);//"accessSettings-view_1"

        LContextAccessSettings.setQueryString("SELECT e FROM daex$AccessSettings e" +
                //" JOIN daex$Expertise exp ON exp.id = e.expertiseAccessSettings.id" +
                //" JOIN daex$RPD rpd ON rpd.expertiseRPD.id = exp.id" +//)
                //" JOIN e.expertiseAccessSettings.id = exp.id" +
                " WHERE e.expertiseAccessSettings.id = :id")// +
                //" AND e.employee IS NULL")
                .setParameter("id", expertise.getUuid());


        List<AccessSettings> list = dataManager.loadList(LContextAccessSettings);

        for (AccessSettings item: list)
        {
            Customers.add(item.getUser().getLogin().toString());
        }


        filesDs.addCollectionChangeListener(event->{

            if (event.getOperation() == CollectionDatasource.Operation.REMOVE && filesTable.getSingleSelected()==null)
            {
                buttonUnload.setEnabled(false);
                //showNotification("== && ==", NotificationType.HUMANIZED);
            }

        });

        filesDs.addItemChangeListener(event ->
        {
            if (filesTable.getSingleSelected()==null)
            {
                buttonUnload.setEnabled(false);
                //showNotification("filesTable.getSingleSelected()!=null", NotificationType.HUMANIZED);
            }
            else
            {
                //downloadButton.setEnabled(false);
                buttonUnload.setEnabled(true);
                //showNotification("filesTable.getSingleSelected()==null", NotificationType.HUMANIZED);
            }
        });

        multiUpload.addQueueUploadCompleteListener(() ->
        {
            //checkDatabase();

            for (Map.Entry<UUID, String> entry : multiUpload.getUploadsMap().entrySet())
            {
                UUID fileId = entry.getKey();
                String fileName = entry.getValue();
                FileDescriptor fd = fileUploadingAPI.getFileDescriptor(fileId, fileName);
                // save file to FileStorage
                try {
                    fileUploadingAPI.putFileIntoStorage(fileId, fd);
                } catch (FileStorageException e) {
                    throw new RuntimeException("Ошибка сохранения в FileStorage", e);
                }

                // save file descriptor to database
                FileDescriptor committedFd = dataSupplier.commit(fd);

                // add reloaded FileDescriptor
                getItem().getFiles().add(committedFd);
                //items.getFiles().add(committedFd);//OK

                showNotification("Загружен файл: " + fileName, NotificationType.TRAY);
            }
            //showNotification("Uploaded files: " + multiUpload.getUploadsMap().values(), NotificationType.HUMANIZED);
            multiUpload.clearUploads();

            //RPDFile committedFoo = dataSupplier.commit(getItem());//Сохранение
            Class = dataSupplier.commit(getItem());
            setItem(Class);//Установка текущего обьекта
            filesDs.refresh();

            //RPDFile committedFoo = dataManager.
            //setI
            //super.commit();
            //filesDs.commit();//NOPE
            // commit Foo to save changes
            //Вызов отрисовщика
            //refresh datasource to show changes
            //filesDs.refresh();//NOPE
        });

        multiUpload.addFileUploadErrorListener(event ->
                showNotification("При загрузке произошла ошибка", NotificationType.HUMANIZED));

        if(getItem().getIsFinal())
        {
            multiUpload.setEnabled(false);
            buttonUnload.setEnabled(false);
            buttonAddFile.setEnabled(false);
            buttonRemoveFile.setEnabled(false);
            butttonCreateRA.setEnabled(false);
            butttonEditRA.setEnabled(false);

            buttonFinalVersion.setCaption("Отменить выбор");
        }
    }

    public void AddRecord(Component source)
    {

        //String s1 =items.getSubjectName();//Debug
        //String s2 = items.getPressmark();//Debug

        //if(checkField()!=false)
        {
            //dataManager.commit(getItem());
            checkDatabase();
            //super.commit();

            RemarkAnswer RAclass = metadata.create(RemarkAnswer.class);
            RAclass.setRpdFile(getItem());
            //RAclass.setFixed(false);

            AbstractEditor RAEditor = openEditor//ERROR
                    (
                            RAclass,
                            WindowManager.OpenType.THIS_TAB,//.DIALOG THIS_TAB
                            //ParamsMap.of(
                            //"expertiseName", expertiseName, // Pass Customer to the Products lookup screen
                            //"sectionName", getItem().getSection().getPressmark()
                            //),
                            null,
                            remarkAnswersDs
                    );
            RAEditor.addCloseWithCommitListener(() ->
            {
                //String s= RAclass.getRemark();
               //RAclass.
                remarkAnswersDs.commit();
                //dataManager.commit(RAclass);
                remarkAnswersDs.refresh();
                showNotification("Сохранено", NotificationType.TRAY);
            });
            //RAEditor.cl
        }
    }

    public void AddFile(Component source)
    {
            openLookup("daex$IncomingDocumentFileDescriptor.browse",
                    items -> {
                        {
                            List <IncomingDocumentFileDescriptor> list = new ArrayList<IncomingDocumentFileDescriptor> (items);

                            for (IncomingDocumentFileDescriptor item: list)
                            {
                                //item.getFileDescriptor()
                                filesDs.addItem(item.getFileDescriptor());
                            }
                            //filesDs.addItem();

                            //file = items;
                            //items.size();
                            showNotification("Добавлено " + items.size() + " файл(ов)", NotificationType.HUMANIZED);
                            //showNotification("OPEN", NotificationType.HUMANIZED);
                            //add.setWindowId("daex$IncomingDocumentFileDescriptor.browse");
                            filesDs.refresh();
                        }
                    },
                    WindowManager.OpenType.THIS_TAB,
                    ParamsMap.of(
                            "Customers", Customers
                    )
            );


    }

    public void FinalVersion(Component source){

            if (getItem().getIsFinal())
            {
                getItem().setIsFinal(false);
                this.commitAndClose();
            }
            else
            {
                if(service.FinalVersion(getItem().getId()) )
                {
                    getItem().setIsFinal(true);
                    this.commitAndClose();
                }
                else
                {
                    showNotification("Имеются не устраненные замечания!",NotificationType.ERROR_HTML);
                }
                //buttonFinalVersion.setCaption("Отменить выбор");
                //showNotification("!!");
            }
    }

    public void onDownloadButtonClick() {

        Entity item = filesTable.getSingleSelected();

        if (getItem().getFiles() != null && item != null)
        {
            List<FileDescriptor> files=getItem().getFiles();

            for(int i = 0; i< files.size(); i++)
            {
                FileDescriptor fileD = files.get(i);
                //String ss11 = fileD.getId().toString();


                if(item.getId().toString().compareTo(fileD.getId().toString()) == 0) {//fileD.getId().toString().compareTo(selectFileID)
                    exportDisplay.show(fileD, ExportFormat.OCTET_STREAM);
                    //showNotification(fileD.getName() + " скачивание завершено!", NotificationType.TRAY);
                }
                //showNotification("NOFIND!", NotificationType.HUMANIZED);
            }
            //downloadButton.setEnabled(false);
        }
        else
            showNotification("Файл не выбран!", NotificationType.HUMANIZED);
    }

    private void checkDatabase() {

        LoadContext loadContext = LoadContext.create(RPDFile.class)
                .setQuery(LoadContext.createQuery("select p from daex$RPDFile p where p.id = :Id")
                        .setParameter("Id", getItem().getId()));
        //.setView("bookPublication.full");
        List <RPDFile> list = dataManager.loadList(loadContext);

        if(list.size()==0) {
            //dataManager.commit(getItem());
            Class = dataSupplier.commit(getItem());
            //dataSupplier.commit(getItem());
            setItem(Class);//OK
            //rpdFileClass = getItem();
        }
        /*else if(list.size()==1)
        {
            rpdFileClass = list.get(0);
            setItem(rpdFileClass);
        }
            else
                showNotification("Произошка ошибка (Код: RPDF-01CDB)", NotificationType.ERROR);
*/
    }

    /*
    public boolean checkField()
    {
        //String s1 = getItem().getHeadRPD().getPressmark();
        //String s2 = getItem().getTom().toString();

        if(getItem().getHeadRPD().getPressmark() == null && getItem().getTom().toString() == null)
            return false;
        else
            return true;
    }
*/

}