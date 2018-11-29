package com.company.daex.web.incomingdocumentfiledescriptor;

import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.core.global.filter.QueryFilter;
import com.haulmont.cuba.gui.WindowParam;
import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.Filter;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.security.entity.FilterEntity;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class IncomingDocumentFileDescriptorBrowse extends AbstractLookup {

    //DataSource
    @Inject
    private CollectionDatasource<FileDescriptor, UUID> incomingDocumentFileDescriptorsDs;

    @Inject
    private Metadata metadata;

    @Inject
    private Filter filter;


    @WindowParam
    private String Customer;
    @WindowParam
    private List<String> Customers;


    @Override
    public void init(Map<String, Object> params)
    {
        if (Customer != null) {
            incomingDocumentFileDescriptorsDs.setQuery(
                    "SELECT e FROM daex$IncomingDocumentFileDescriptor e" +
                            " JOIN daex$IncomingDocument i ON i.id = e.incomingDocument.id");
                            //" WHERE i.createdBy = :param$Customer");
        }
    }

    @Override
    public void ready() {

        if (Customers != null && !Customers.isEmpty())
        {
            FilterEntity filterEntity = metadata.create(FilterEntity.class);
            filterEntity.setName("Customers");
            filterEntity.setXml(
                    "<filter>\n" +
                    " <and>\n" +
                    " <c name=\"incomingDocument.createdBy\" class=\"java.lang.String\" inExpr=\"true\" operatorType=\"IN\" width=\"1\" type=\"PROPERTY\">" +
                    " <![CDATA[e.incomingDocument.createdBy in :component$filter.Customers]]>\n" +
                    " <param name=\"component$filter.Customers\" javaClass=\"java.lang.String\">NULL</param>\n" +
                    " </c>\n" +
                    " </and>\n" +
                     "</filter>");
            filter.setFilterEntity(filterEntity);
            filter.setParamValue("Customers", Customers);
            filter.apply(true);

        }
    }
}