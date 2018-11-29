package com.company.daex.web.remarkanswer;

import com.company.daex.entity.RPD;
import com.company.daex.entity.RPDFile;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.*;
import com.haulmont.cuba.gui.components.*;
import com.company.daex.entity.RemarkAnswer;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.export.ExportDisplay;
import com.haulmont.cuba.gui.export.ExportFormat;
import com.haulmont.cuba.gui.upload.FileUploadingAPI;
import com.vaadin.data.util.filter.Not;

import javax.inject.Inject;
import java.lang.reflect.Parameter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class RemarkAnswerEdit extends AbstractEditor<RemarkAnswer> {

    //
    @Inject
    private Metadata metadata;
    @Inject
    private DataManager dataManager;

    //DataSource
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> filesDs;

    //MultiFIleUpload
    @Inject
    private FileMultiUploadField multiUpload;
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
    private Button buttonFixed;
    @Inject
    private Button buttonCreateRPDFile;
    @Inject
    private Button buttonUnload;
    @Inject
    private Button buttonAdd;
    @Inject
    private Button buttonRemove;
    @Inject
    private TextArea TextAreaAnswer;
    @Inject
    private TextArea TextAreaRemark;

    private Boolean isAnswer = false;
    //private  RemarkAnswer thisClass;//Доступ к обектам класса

    //Method
    protected void initNewItem(RemarkAnswer item) {
        item.setFilesRemarkAnswer(new ArrayList<>());
    }

    @Override
    public void init(Map<String, Object> params) {
    }

    @Override
    public void ready() {

        filesDs.addCollectionChangeListener(event->{

            if (event.getOperation() == CollectionDatasource.Operation.REMOVE && filesTable.getSingleSelected()==null)
            {
                buttonUnload.setEnabled(false);

                if(isAnswer == true)
                    buttonCreateRPDFile.setEnabled(false);
            }

        });

        filesDs.addItemChangeListener(event ->{
            if (filesTable.getSingleSelected()==null)
            {
                buttonUnload.setEnabled(false);

                if(isAnswer == true)
                    buttonCreateRPDFile.setEnabled(false);
            }
            else
            {
                buttonUnload.setEnabled(true);

                if(isAnswer == true)
                    buttonCreateRPDFile.setEnabled(true);
            }
        });

        multiUpload.addQueueUploadCompleteListener(() ->{
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
                getItem().getFilesRemarkAnswer().add(committedFd);
                //items.getFiles().add(committedFd);//OK

                showNotification("Загружен файл: " + fileName, NotificationType.TRAY);
            }
            //showNotification("Uploaded files: " + multiUpload.getUploadsMap().values(), NotificationType.HUMANIZED);
            multiUpload.clearUploads();

            //RPDFile committedFoo = dataSupplier.commit(getItem());//Сохранение
            //thisClass = dataSupplier.commit(getItem());
            //setItem(thisClass);//Установка текущего обьекта
            filesDs.refresh();
        });

        multiUpload.addFileUploadErrorListener(event ->
                showNotification("При загрузке произошла ошибка", NotificationType.HUMANIZED));

        if(TextAreaAnswer.getRawValue().length() > 1)
        {
            TextAreaRemark.setEnabled(false);
            buttonFixed.setEnabled(true);
            multiUpload.setEnabled(false);
            buttonUnload.setEnabled(false);
            buttonAdd.setEnabled(false);
            buttonRemove.setEnabled(false);
            isAnswer = true;
            //showNotification("! " + TextAreaAnswer.getRawValue().length());
        }

    }

    public void Fixed(){

        getItem().setIsFixed(true);
        this.commitAndClose();

        /*
        if(getItem().getIsFixed() || getItem().getIsFixed() == null)
        {
            getItem().setIsFixed(false);
            //buttonFinalVersion.setCaption("Выбрать финальной версией");
        }
        else
        {
            getItem().setIsFixed(true);
            //buttonFinalVersion.setCaption("Отменить выбор");
        }*/
    }

    public void Unload() {

        Entity item = filesTable.getSingleSelected();

        if (getItem().getFilesRemarkAnswer() != null && item != null)
        {
            List<FileDescriptor> files=getItem().getFilesRemarkAnswer();

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

    public void CreateRPDFile()
    {
        FileDescriptor item = (FileDescriptor) filesTable.getSingleSelected();

        RPDFile Class = metadata.create(RPDFile.class);

        ///1 Получить РПД
        LoadContext<RPDFile> LContextF = LoadContext.create(RPDFile.class);
        LContextF.setView(View.MINIMAL);

        //UUID id = getItem().getRpdFile().getUuid();
        //LContext.setQueryString("SELECT e FROM daex$RPD e  WHERE e.expertiseRPD.id = :id")
        LContextF.setQueryString("SELECT e FROM daex$RPDFile e " +
                "WHERE e.id = :id")
                .setParameter("id", getItem().getRpdFile().getUuid());

        List<RPDFile> listF = dataManager.loadList(LContextF);

        if(listF.size() == 1)
        {
            LoadContext<RPD> LContextRPD = LoadContext.create(RPD.class);
            LContextRPD.setView(View.MINIMAL);


            //RPDFile Class_1 = listF.get(0);
            //UUID id = Class_1.getRpd().getUuid();

            LContextRPD.setQueryString("SELECT e FROM daex$RPD e " +
                    "WHERE e.id = :id")
                    .setParameter("id", listF.get(0).getRpd().getUuid());

            List<RPD> listRPD = dataManager.loadList(LContextRPD);

            if(listRPD.size() ==1)
            {
                ///2 Заполнить поля
                Class.setRpd(listRPD.get(0));

                List<FileDescriptor> listFD = new ArrayList();
                listFD.add(item);
                Class.setFiles(listFD);

                ///3 Сохранить
                dataManager.commit(Class);

                showNotification("Файл добавлен к разделу!", NotificationType.TRAY);
            }
        }
    }

    /*
        TextAreaAnswer.addValueChangeListener(event->{
            if(TextAreaAnswer.getRawValue().length() > 1)
            {
                TextAreaRemark.setEnabled(false);
                buttonFixed.setEnabled(true);
                multiUpload.setEnabled(false);
                buttonUnload.setEnabled(false);
                buttonAdd.setEnabled(false);
                buttonRemove.setEnabled(false);
                //showNotification("! " + TextAreaAnswer.getRawValue().length());
            }
        });*/
        /*
        TextAreaAnswer.addTextChangeListener(event->{

            if(TextAreaAnswer.getRawValue().length() > 1)
            {
                buttonFixed.setEnabled(true);
                multiUpload.setEnabled(false);
                buttonUnload.setEnabled(false);
                buttonAdd.setEnabled(false);
                buttonRemove.setEnabled(false);
                showNotification("!! " + TextAreaAnswer.getRawValue().length());
            }
            //showNotification("!! " + TextAreaAnswer.getRawValue().length());
            //showNotification("!!! " + TextAreaAnswer.getValue().toString().length());
            //TextAreaAnswer.getValue().toString().length()
        });*/
    //thisClass = null;

}