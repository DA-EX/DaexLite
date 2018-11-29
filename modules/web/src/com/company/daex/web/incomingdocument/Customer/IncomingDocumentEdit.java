package com.company.daex.web.incomingdocument.Customer;

import com.company.daex.entity.IncomingDocumentFileDescriptor;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.FileStorageException;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.core.global.View;
import com.haulmont.cuba.gui.components.*;
import com.company.daex.entity.IncomingDocument;
import com.haulmont.cuba.gui.components.actions.RemoveAction;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.export.ExportDisplay;
import com.haulmont.cuba.gui.export.ExportFormat;
import com.haulmont.cuba.gui.upload.FileUploadingAPI;

import javax.inject.Inject;
import javax.inject.Named;
import javax.persistence.EntityManager;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.transaction.Transaction;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class IncomingDocumentEdit extends AbstractEditor<IncomingDocument> {
    //DataSource
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> filesDs;

    //MultiFIleUpload
    @Inject
    private FileUploadingAPI fileUploadingAPI;
    @Inject
    private DataSupplier dataSupplier;

    @Inject
    private ExportDisplay exportDisplay;
    @Inject
    private Metadata metadata;
    //@Inject
    //private Persistence persistence;

    //Items
    @Inject
    private FileMultiUploadField multiUpload;
    @Inject
    private TextArea textAreaDescription;
    @Inject
    private Button buttonRemove;
    @Inject
    private Table filesTable;
    @Inject
    private Button buttonUnload;

    @Named("filesTable.remove")
    private RemoveAction remove;

    private Entity entityItem;

    private List<FileDescriptor> listFD;

    protected void initNewItem(IncomingDocument item) {
        item.setFiles(new ArrayList<>());
        listFD = new ArrayList<>();
        //item.setFiles(new ArrayList<>());
    }

    @Override
    public void init(Map<String, Object> params) {
        //Class = null;
        //remove.setWindowId("daex$IncomingDocumentFileDescriptor.browse");
    }

    @Override
    public void ready()
    {

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

        remove.setBeforeActionPerformedHandler(()->{
            entityItem = filesTable.getSingleSelected();

            for (FileDescriptor item: listFD)
            {
                if(item.getId() == entityItem.getId())
                {
                    listFD.remove(item);
                    break;
                }
            }

            //showNotification("The customer instance will be removed");
            return isValid();
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

                listFD.add(committedFd);

                // add reloaded FileDescriptor
                getItem().getFiles().add(committedFd);
                //items.getFiles().add(committedFd);//OK

                showNotification("Загружен файл: " + fileName, NotificationType.TRAY);
            }
            //showNotification("Uploaded files: " + multiUpload.getUploadsMap().values(), NotificationType.HUMANIZED);
            multiUpload.clearUploads();
            filesDs.refresh();

            //IncomingDocument committedFoo = dataSupplier.commit(getItem());//Сохранение
            //setItem(committedFoo);//Установка текущего обьекта

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


        if(getItem().getVersion() != null)
        {   //showNotification("!!!!!");
            multiUpload.setEnabled(false);
            textAreaDescription.setEnabled(false);
            buttonRemove.setEnabled(false);
        }

    }

    public void Unload() {

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

    @Override
    protected boolean postCommit(boolean committed, boolean close)
    {
        for(FileDescriptor item: listFD)
        {
            IncomingDocumentFileDescriptor Class = metadata.create(IncomingDocumentFileDescriptor.class);

            Class.setFileDescriptor(item);
            Class.setIncomingDocument(getItem());
            dataSupplier.commit(Class);
        }

        return true;
    }
}