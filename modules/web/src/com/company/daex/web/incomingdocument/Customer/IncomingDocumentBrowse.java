package com.company.daex.web.incomingdocument.Customer;

import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.actions.CreateAction;
import com.haulmont.cuba.gui.components.actions.EditAction;

import javax.inject.Named;
import java.util.Map;

public class IncomingDocumentBrowse extends AbstractLookup {

    @Named("incomingDocumentsTable.create")
    private CreateAction TableCreate;

    @Named("incomingDocumentsTable.edit")
    private EditAction TableEdit;

    @Override
    public void init(Map<String, Object> params) {
        TableCreate.setWindowId("daex$IncomingDocumentCustomer.edit");
        TableEdit.setWindowId("daex$IncomingDocumentCustomer.edit");
    }
}