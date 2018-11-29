package com.company.daex.web.expertise.Customer;

import com.company.daex.entity.Expertise;
import com.haulmont.cuba.core.global.AppBeans;
import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.gui.components.AbstractLookup;
import com.haulmont.cuba.gui.components.Button;
import com.haulmont.cuba.gui.components.Table;
import com.haulmont.cuba.gui.components.actions.CreateAction;
import com.haulmont.cuba.gui.components.actions.EditAction;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.reports.entity.Report;
import com.haulmont.reports.gui.ReportGuiManager;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class ExpertiseBrowse extends AbstractLookup {

    @Inject
    private DataManager dataManager;

    private ReportGuiManager reportGuiManager = AppBeans.get(ReportGuiManager.class);

    //DataSource
    @Inject
    private CollectionDatasource<Expertise, UUID> expertisesDs;

    //Items
    @Inject
    private Button buttonReport_1;
    @Inject
    private Button buttonReport_2;
    @Inject
    private Table expertisesTable;

    @Named("expertisesTable.edit")
    private EditAction TableEdit;

    @Override
    public void init(Map<String, Object> params) {
        TableEdit.setWindowId("daex$ExpertiseCustomer.edit");
    }

    @Override
    public void ready() {

        expertisesDs.addCollectionChangeListener(event->
        {

            if (event.getOperation() == CollectionDatasource.Operation.REMOVE && expertisesTable.getSingleSelected()==null)
            {
                buttonReport_1.setEnabled(false);
                buttonReport_2.setEnabled(false);
            }

        });

        expertisesDs.addItemChangeListener(event ->
        {
            if (expertisesTable.getSingleSelected()==null)
            {
                buttonReport_1.setEnabled(false);
                buttonReport_2.setEnabled(false);
            }
            else
            {
                buttonReport_1.setEnabled(true);
                buttonReport_2.setEnabled(true);
            }
        });

    }

    public void Report_1()
    {
        Map<String, Object> reportParams = new HashMap<>();
        reportParams.put("E", expertisesTable.getSelected());

        LoadContext<Report> lContext = new LoadContext<>(Report.class);
        lContext.setQueryString("select r from report$Report r where r.code = 'Report_1' ");

        Report report = dataManager.load(lContext);
        reportGuiManager.printReport(report, reportParams, "DEFAULT", "Report_1");
    }

    public void Report_2()
    {
        Map<String, Object> reportParams = new HashMap<>();
        reportParams.put("E", expertisesTable.getSelected());

        LoadContext<Report> lContext = new LoadContext<>(Report.class);
        lContext.setQueryString("select r from report$Report r where r.code = 'Report_2' ");

        Report report = dataManager.load(lContext);
        reportGuiManager.printReport(report, reportParams, "DEFAULT", "Report_2");
    }
}