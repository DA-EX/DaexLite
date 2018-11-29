package com.company.daex.web.incomingdocument;

import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.gui.components.AbstractEditor;
import com.company.daex.entity.IncomingDocument;
import com.haulmont.cuba.gui.components.Button;
import com.haulmont.cuba.gui.components.Table;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.export.ExportDisplay;
import com.haulmont.cuba.gui.export.ExportFormat;

import javax.inject.Inject;
import java.util.List;
import java.util.UUID;

public class IncomingDocumentEdit extends AbstractEditor<IncomingDocument> {

    @Inject
    private ExportDisplay exportDisplay;

    //DataSource
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> filesDs;
    //Items
    @Inject
    private Table filesTable;
    @Inject
    private Button buttonDownload;


    @Override
    public void ready() {

        filesDs.addCollectionChangeListener(event->{

            if (event.getOperation() == CollectionDatasource.Operation.REMOVE && filesTable.getSingleSelected()==null)
            {
                buttonDownload.setEnabled(false);
                //showNotification("== && ==", NotificationType.HUMANIZED);
            }

        });

        filesDs.addItemChangeListener(event ->
        {
            if (filesTable.getSingleSelected()==null)
            {
                buttonDownload.setEnabled(false);
                //showNotification("filesTable.getSingleSelected()!=null", NotificationType.HUMANIZED);
            }
            else
            {
                //downloadButton.setEnabled(false);
                buttonDownload.setEnabled(true);
                //showNotification("filesTable.getSingleSelected()==null", NotificationType.HUMANIZED);
            }
        });
    }

    public void DownloadButtonClick() {

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
}