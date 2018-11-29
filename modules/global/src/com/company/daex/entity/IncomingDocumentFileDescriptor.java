package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.cuba.core.entity.FileDescriptor;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|id")
@Table(name = "DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR")
@Entity(name = "daex$IncomingDocumentFileDescriptor")
public class IncomingDocumentFileDescriptor extends StandardEntity {
    private static final long serialVersionUID = -2170134284953581968L;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "INCOMING_DOCUMENT_ID")
    protected IncomingDocument incomingDocument;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "FILE_DESCRIPTOR_ID")
    protected FileDescriptor fileDescriptor;

    public void setIncomingDocument(IncomingDocument incomingDocument) {
        this.incomingDocument = incomingDocument;
    }

    public IncomingDocument getIncomingDocument() {
        return incomingDocument;
    }

    public void setFileDescriptor(FileDescriptor fileDescriptor) {
        this.fileDescriptor = fileDescriptor;
    }

    public FileDescriptor getFileDescriptor() {
        return fileDescriptor;
    }


}