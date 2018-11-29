package com.company.daex.web.expertise;

import com.company.daex.entity.AccessSettings;
import com.company.daex.entity.RPD;
import com.company.daex.service.ExpertiseService;
import com.haulmont.bali.util.ParamsMap;
import com.haulmont.chile.core.model.Session;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.FileStorageException;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.WindowParams;
import com.haulmont.cuba.gui.components.*;
import com.company.daex.entity.Expertise;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.data.GroupDatasource;
import com.haulmont.cuba.core.global.UserSessionSource;
import com.haulmont.cuba.gui.export.ExportDisplay;
import com.haulmont.cuba.gui.export.ExportFormat;
import com.haulmont.cuba.gui.upload.FileUploadingAPI;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class ExpertiseEdit extends AbstractEditor<Expertise> {

    //Create Editor and transport Window
    @Inject
    private Metadata metadata;
    @Inject
    private UserSessionSource userSessionSource;
    @Inject
    private ExpertiseService service;

    //DataSource
    @Inject
    private CollectionDatasource<RPD, UUID> rpdDs;//partsDs parts
    @Inject
    private CollectionDatasource<AccessSettings, UUID> accessSettingsesEmployee;
    @Inject
    private CollectionDatasource<AccessSettings, UUID> accessSettingsesCustomer;
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> filesDs;

    //MultiFIleUpload
    @Inject
    private FileMultiUploadField FmultiUpload;
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
    private Button buttonDownloadFile;
    @Inject
    private TextField textFieldENumber;

    private  Entity entityItem;
    //private  Expertise items;//Доступ к обектам класса Expertise
    //private String selectFileID;

    //Method
    @Override
    protected void initNewItem(Expertise item) {
        item.setFiles(new ArrayList<>());
    }

    @Override
    public void init(Map<String, Object> params) {
        //items = (Expertise) WindowParams.ITEM.getEntity(params);
        //if(getItem().getLeaderEmployee() == null) {
        //    userSessionSource.getUserSession().getUser().getUuid();
        //}

        super.init(params);
    }

    @Override
    public void ready() {

        filesDs.addCollectionChangeListener(event->{

            if (event.getOperation() == CollectionDatasource.Operation.REMOVE && filesTable.getSingleSelected()==null)
            {
                buttonDownloadFile.setEnabled(false);
                //showNotification("== && ==", NotificationType.HUMANIZED);
            }

        });

        filesDs.addItemChangeListener(event ->
        {
            if (filesTable.getSingleSelected()==null)
            {
                buttonDownloadFile.setEnabled(false);
                //showNotification("filesTable.getSingleSelected()!=null", NotificationType.HUMANIZED);
            }
            else
            {
                //downloadButton.setEnabled(false);
                buttonDownloadFile.setEnabled(true);
                //showNotification("filesTable.getSingleSelected()==null", NotificationType.HUMANIZED);
            }
        });

        FmultiUpload.addQueueUploadCompleteListener(() ->
        {
            if (this.CheckField() != false) {
                for (Map.Entry<UUID, String> entry : FmultiUpload.getUploadsMap().entrySet()) {
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
                    showNotification("Загружен файл: " + fileName, NotificationType.TRAY);
                }
                //showNotification("Uploaded files: " + multiUpload.getUploadsMap().values(), NotificationType.HUMANIZED);
                FmultiUpload.clearUploads();

                // commit Foo to save changes
                Expertise committedFoo = dataSupplier.commit(getItem());
                setItem(committedFoo);

                // refresh datasource to show changes
                filesDs.refresh();
            }
        });

        FmultiUpload.addFileUploadErrorListener(event ->{
            showNotification("При загрузке произошла ошибка", NotificationType.HUMANIZED);
        });

        if(getItem().getLeaderEmployee() == null)
        {
            getItem().setLeaderEmployee(service.GetEmployee(userSessionSource.getUserSession().getUser().getId()));
            //showNotification("LeaderEmployee");
        }
        //getItem().setLeaderEmployee(userSessionSource.getUserSession().getUser().getId());
        //String name = getItem().getLeaderEmployee().getFirstName();
        //showNotification(name);

    }

    public void AddRecord(Component source) {
        //String s1 =items.getSubjectName();//Debug
        //String s2 = items.getPressmark();//Debug

        if(this.CheckField()!=false)
        {
            //super.commit();//Создает в БД

            RPD RPDclass = metadata.create(RPD.class);
            RPDclass.setExpertiseRPD(getItem());
            String sq = RPDclass.getUuid().toString();

            AbstractWindow editor = openEditor
                    (
                            RPDclass,
                            WindowManager.OpenType.THIS_TAB,//.DIALOG THIS_TAB
                            ParamsMap.of(
                                    //"expertiseName", items.getSubjectName(),
                                    "pressmarkExpertise", getItem().getPressmark()
                            ),
                            rpdDs
                    );
            editor.addCloseWithCommitListener(()->{
                rpdDs.commit();
                rpdDs.refresh();
            });
        }
    }

    public void AddAccessSetting(Component source) {

        if(this.CheckField()!=false)
        {
            //super.commit();//Создает в БД

            AccessSettings Class = metadata.create(AccessSettings.class);
            Class.setExpertiseAccessSettings(getItem());

            AbstractWindow editor = openEditor
                    (
                            Class,
                            WindowManager.OpenType.THIS_TAB,//.DIALOG THIS_TAB
                            null,
                            accessSettingsesEmployee
                    );

            editor.addCloseWithCommitListener(()->{
                accessSettingsesEmployee.commit();
                accessSettingsesEmployee.refresh();
                accessSettingsesCustomer.refresh();
            });
        }
    }

    public void onDownloadButtonClick() {

        entityItem = filesTable.getSingleSelected();

        if (getItem().getFiles() != null && entityItem != null)
        {
            List<FileDescriptor> files=getItem().getFiles();

            for(int i = 0; i< files.size(); i++)
            {
                FileDescriptor fileD = files.get(i);
                //String ss11 = fileD.getId().toString();


                if(entityItem.getId().toString().compareTo(fileD.getId().toString()) == 0) {//fileD.getId().toString().compareTo(selectFileID)
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

    public void InEGRZ()
    {
        showNotification("" + service.EGRZ(getItem().getUuid(), getItem().getPressmark()), NotificationType.HUMANIZED_HTML);
    }

    private boolean CheckField(){
        if(super.commit()==true)
            return true;
        else {
            showNotification("Проверте заполнение обязательных полей",NotificationType.ERROR);
            return false;
        }

    }
}