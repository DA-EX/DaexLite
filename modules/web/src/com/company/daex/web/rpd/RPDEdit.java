package com.company.daex.web.rpd;

import com.company.daex.entity.RPDFile;
import com.haulmont.bali.util.ParamsMap;
import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.global.Metadata;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.WindowParam;
import com.haulmont.cuba.gui.WindowParams;
import com.haulmont.cuba.gui.components.AbstractEditor;
import com.company.daex.entity.RPD;
import com.haulmont.cuba.gui.components.Component;
import com.haulmont.cuba.gui.components.FieldGroup;
import com.haulmont.cuba.gui.components.TextField;
import com.haulmont.cuba.gui.data.CollectionDatasource;
import com.haulmont.cuba.gui.data.DataSupplier;
import com.haulmont.cuba.gui.data.Datasource;
import com.haulmont.cuba.gui.data.DsContext;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class RPDEdit extends AbstractEditor<RPD> {

    //InputData
    //@WindowParam
    //private String expertiseName;

    @WindowParam
    private String pressmarkExpertise;

    //DataSource
    @Inject
    private CollectionDatasource<RPDFile, UUID> rpdFilesDs;//partsDs parts

    @Inject
    private TextField fieldTom;

    //@Inject
    //private Datasource<RPD> rpdDs;

    //Create Editor and transport Window
    @Inject
    private Metadata metadata;

    @Inject
    private DataManager dataManager;
    @Inject
    private DataSupplier dataSupplier;

    //@Inject
    //private TextField pressmark;

    private RPD RDPClass;
    //private  RPD items;//Доступ к обектам класса Expertise

    //Method
    @Override
    public void init(Map<String, Object> params) {
        RDPClass = null;
        super.init(params);

        fieldTom.addValueChangeListener(event -> {
                    //showNotification("Text Changed: " + fieldTom.getValue().toString());
            SetPressmark();
                });



        /*
        tom.addValueChangeListener(listener->{
            SetPressmark();
        });
*/
        //pressmark.
        //pressmark.addText

        //setItem(getItem());
        //DsContext dsContex = getDsContext();
        //dsContex.commit();
        //items = (RPD) WindowParams.ITEM.getEntity(params);


    }

    @Override
    public void ready() {
        //rpdFilesDs.refresh();
/*
        if( items.getPressmark() == null && items.getTom()!= null && items.getHeadRPD()!= null)
        {
            //items.setPressmark(pressmark.toString() + "-" + items.getTom() + "-" + items.getHeadRPD().getName() + "-");
        }*/
    }

    public void AddRecord(Component source) {

        //String s1 =items.getSubjectName();//Debug
        //String s2 = items.getPressmark();//Debug

        if(CheckField()!=false)
        {

            //super.commit();
            checkDatabase();

            RPDFile RPDFileclass = metadata.create(RPDFile.class);
            RPDFileclass.setRpd(getItem());
            //RPDFileclass.setIsFinal(false);

            AbstractEditor RAEditor = openEditor
                    (
                            RPDFileclass,
                            WindowManager.OpenType.THIS_TAB,//.DIALOG THIS_TAB
                            //ParamsMap.of(
                                    //"expertiseName", expertiseName, // Pass Customer to the Products lookup screen
                                    //"sectionName", getItem().getSection().getPressmark()
                            //),
                            null,
                            rpdFilesDs
                    );
            RAEditor.addCloseWithCommitListener(() ->
            {
                rpdFilesDs.commit();
                rpdFilesDs.refresh();
                showNotification("Сохранено", NotificationType.TRAY);
            });
        }
    }
/*
    public boolean CheckField(){//Проверить

        if(getItem().getHeadRPD()!=null && getItem().getTom() != null)
        {
            //String s1 = getItem().getHeadRPD().getPressmark().toString();
            //String s2 = getItem().getTom().toString();


/*
            //string.trim().length() == 0
            if (getItem().getHeadRPD().getPressmark().trim().length() == 0) {
                if (getItem().getTom().toString().trim().length() == 0) {
                    showNotification("Заполните поля Раздел и Том", NotificationType.TRAY);
                    return false;
                } else {
                    showNotification("Заполните поле Раздел", NotificationType.ERROR);
                    return false;
                }
            } else {
                if (getItem().getTom().toString().trim().length() == 0) {
                    showNotification("Заполните поле Том", NotificationType.WARNING);
                    return false;
                } else
                    return true;
            }*//*
            return true;
        }
        else
        {
            showNotification("Проверьте правильность заполнения полей", NotificationType.ERROR_HTML);
            return false;
        }
    }*/

    private boolean CheckField(){

        if(getItem().getHeadRPD() != null && getItem().getTom() != null)
        {
            if(     getItem().getHeadRPD().getPressmark()!= null){

                if(     getItem().getHeadRPD().getPressmark().toString().length() != 0 &&
                        getItem().getTom().toString().length() != 0) {
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }
        else
            return false;
    }

    private void SetPressmark(){
        if(this.CheckField() && pressmarkExpertise != null)
        {
            getItem().setPressmark(pressmarkExpertise.toString() + "-" + getItem().getHeadRPD().getPressmark() + "-" + getItem().getTom());
        }
    }

    private void checkDatabase() {

        LoadContext loadContext = LoadContext.create(RPD.class)
                .setQuery(LoadContext.createQuery("select p from daex$RPD p where p.id = :Id")
                        .setParameter("Id", getItem().getId()));
                //.setView("bookPublication.full");
        List <RPD> list = dataManager.loadList(loadContext);

        if(list.size()==0) {
            RDPClass = dataSupplier.commit(getItem());
            setItem(RDPClass);
        }
        /*else
        {
            RDPClass = list.get(0);
            setItem(RDPClass);
        }*/
    }
}