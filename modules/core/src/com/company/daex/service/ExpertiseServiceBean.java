package com.company.daex.service;

import com.company.daex.entity.*;
import com.haulmont.cuba.core.*;
import com.haulmont.cuba.core.entity.FileDescriptor;

import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.FileLoader;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.global.View;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.swing.text.html.parser.Entity;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.zip.*;
import java.util.Date;
import java.io.*;

@Service(ExpertiseService.NAME)
public class ExpertiseServiceBean implements ExpertiseService {

    @Inject
    private DataManager dataManager;
    @Inject
    private FileLoader fileLoader;
    @Inject
    private Persistence persistence;
    //@Inject
    //private ExportDisplay exportDisplay;

    //private FileDescriptor fileDescriptor;

    ///Финализация RPDFile
    public boolean FinalVersion(UUID id)
    {

        LoadContext<RemarkAnswer> LContext = LoadContext.create(RemarkAnswer.class);
        LContext.setView(View.MINIMAL);
        LContext.setQueryString("SELECT e FROM daex$RemarkAnswer e WHERE e.rpdFile.id = :id AND e.isFixed = FALSE")
                .setParameter("id", id);

        List<RemarkAnswer> list = dataManager.loadList(LContext);

        if (list.size() == 0)
        {
            return true;
        }
        else
            return false;
    }

    public String EGRZ(UUID id, String expertiseName)
    {
        if(VerifyCompleteness(id))
        {
            try
            {
                InZIP(id, expertiseName);
            }
            catch(Exception ex)
            {
                return "Ошибка формирования архива! " + ex.toString();
            }
            return "Архив сформирован";
        }
        else
            return "Проверка на наличие финальных версий не пройдена!";

    }

    ///Получение текущего пользователя из таблицы Сотрудников
    public Employee GetEmployee(UUID id)
    {
        LoadContext<Employee> LContext = LoadContext.create(Employee.class);
        LContext.setView(View.MINIMAL);
        LContext.setQueryString("SELECT e FROM daex$Employee e WHERE e.user_sys.id= :id")
                .setParameter("id", id);

        return dataManager.load(LContext);
    }

    ///Рекурсивная проверка на наличие Финальной версии на разделах и файлах
    private boolean VerifyCompleteness(UUID id)
    {
        //1 РПД
        //2 РПД Файл
        LoadContext<RPD> LContext = LoadContext.create(RPD.class);
        LContext.setView(View.MINIMAL);
        LContext.setQueryString("SELECT e FROM daex$RPD e  WHERE e.expertiseRPD.id = :id")
                .setParameter("id", id);

        List<RPD> list = dataManager.loadList(LContext);

        boolean isFlag = false;

        if (list != null)
        {
            int index = list.size();

            for (RPD item:list)
            {
                LoadContext<RPDFile> LContext_ = LoadContext.create(RPDFile.class);
                LContext_.setView(View.MINIMAL);
                LContext_.setQueryString("SELECT e FROM daex$RPDFile e  WHERE e.rpd.id = :id AND e.isFinal = TRUE")
                        .setParameter("id", item.getId());

                List<RPDFile> list_ = dataManager.loadList(LContext_);

                if(list_.size() != 0)
                {
                    index--;
                }
            }

            if(index == 0)
                isFlag = true;
        }

        return isFlag;
    }

    ///Создание архива для выгрузки
    private void InZIP(UUID id, String expertiseName) throws Exception
    {
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd_MM_yyyy_hh-mm");

        ///Создание архива
        try(ZipOutputStream out = new ZipOutputStream(new FileOutputStream( "C:\\Users\\ms\\Desktop\\testZIP\\" + format.format(date) + ".zip")))///Поток вывода архива
        {
            out.setLevel(9);//Уровень сжатия

            List<FileDescriptor> listFD = new ArrayList();
            ///Открытие транзацкции
            try (Transaction tx = persistence.createTransaction()) {
                EntityManager entityManager = persistence.getEntityManager();
                ///1 Рекурсивно скачиваем файлы из Экспертизы
                TypedQuery<FileDescriptor> queryExpertise = entityManager.createNativeQuery("SELECT * FROM sys_file " +
                        "JOIN daex_expertise_file_descriptor_link ON  daex_expertise_file_descriptor_link.file_descriptor_id = sys_file.id " +
                        "WHERE daex_expertise_file_descriptor_link.expertise_id = #id", FileDescriptor.class)
                        .setParameter("id", id);

                listFD = queryExpertise.getResultList();///Файлы

                for (FileDescriptor itemF : listFD) ///Добавляем
                {
                    InputStream inputStream = fileLoader.openStream(itemF);

                    out.putNextEntry(new ZipEntry(expertiseName + "/" + itemF.getName()));
                    WriteInZip(inputStream, out);
                }

                ///2 Получение Разделов
                LoadContext<RPD> LContextRPD = LoadContext.create(RPD.class);
                LContextRPD.setView(View.BASE);

                LContextRPD.setQueryString("SELECT e FROM daex$RPD e " +
                        "WHERE e.expertiseRPD.id = :id")
                        .setParameter("id", id);

                List<RPD> listRPD = dataManager.loadList(LContextRPD);

                for (RPD itemRPD:listRPD)
                {
                    ///3 Получение Файлов Разделов
                    LoadContext<RPDFile> LContextRPDFile = LoadContext.create(RPDFile.class);
                    LContextRPDFile.setView(View.BASE);

                    LContextRPDFile.setQueryString("SELECT e FROM daex$RPDFile e " +
                            "WHERE e.rpd.id = :id AND e.isFinal = TRUE")
                            .setParameter("id", itemRPD.getUuid());

                    List<RPDFile> listRPDFile = dataManager.loadList(LContextRPDFile);

                    for (RPDFile itemRPDFile: listRPDFile)
                    {
                        ///4 Рекурсивно скачиваем файлы из Файлов Разделов
                        TypedQuery<FileDescriptor> queryRPDFile = entityManager.createNativeQuery("SELECT * FROM sys_file " +
                                "JOIN daex_rpd_file_file_descriptor_link ON  daex_rpd_file_file_descriptor_link.file_descriptor_id = sys_file.id " +
                                "WHERE daex_rpd_file_file_descriptor_link.r_p_d_file_id = #id", FileDescriptor.class)
                                .setParameter("id", itemRPDFile.getUuid());

                        listFD = queryRPDFile.getResultList();//Файлы

                        for (FileDescriptor itemF : listFD)///Добавляем
                        {
                            InputStream inputStream = fileLoader.openStream(itemF);

                            out.putNextEntry(new ZipEntry(expertiseName + "/" + itemRPD.getPressmark() +"/" + itemF.getName()));
                            WriteInZip(inputStream, out);
                        }

                    }

                }

                tx.close();
            }///EndTransaction

            out.close();
        }///EndZipOut









        //exportDisplay.show(fileD, ExportFormat.OCTET_STREAM);


/*
/*
        LoadContext<FileDescriptor> LContextFD = LoadContext.create(FileDescriptor.class);
        LContextFD.setView(View.BASE);

        LContextFD.setQueryString("SELECT e FROM daex$Expertise e " +
                "INNER JOIN e.files f " +
                "WHERE e.id = :id")
                .setParameter("id", id);
*//*
        LoadContext<Expertise> LContextE = LoadContext.create(Expertise.class);
        LContextE.setView(View.BASE);

        LContextE.setQueryString("SELECT e FROM daex$Expertise e " +
                "INNER JOIN e.files f " +
                "WHERE e.id = :id")
                .setParameter("id", id);

        //LContextE.setQueryString("SELECT e FROM daex$expertise_file_descriptor_link e");//daex_expertise_file_descriptor_link
        List<Expertise> listE = dataManager.loadList(LContextE);*/
        //List<FileDescriptor> listFD = dataManager.loadList(LContextFD);
//---------------------------------------------------
/*        for (FileDescriptor item:listFD)
        {
            InputStream inputStream = fileLoader.openStream(item);
            //textAreaOut.setValue(IOUtils.toString(inputStream));

            out.putNextEntry(new ZipEntry(expertiseName + "/" + item.getName()));
            WriteInZip(inputStream, out);
            out.close();
        }
*//*
        ///2 Получаем все разделы RPD
        LoadContext<RPD> LContextRPD = LoadContext.create(RPD.class);
        LContextRPD.setView(View.MINIMAL);
        LContextRPD.setQueryString("SELECT e FROM daex$RPD e  WHERE e.expertiseRPD.id = :id")
                .setParameter("id", id);

        List<RPD> listRPD = dataManager.loadList(LContextRPD);

        for (RPD item:listRPD)
        {
            ///3 Рекурсивно выкачиваем файлы из RPDFile
            LoadContext<FileDescriptor> LContextRPDFile = LoadContext.create(FileDescriptor.class);
            LContextRPDFile.setView(View.MINIMAL);
            LContextRPDFile.setQueryString("SELECT e FROM sys_file e  " +
                    "JOIN daex_rpd_file_file_descriptor_link l ON  l.file_descriptor_id = e.id" +
                    "WHERE l.r_p_d_file_id = :id")
                    .setParameter("id", item.getId());

            List<FileDescriptor> listRPDFile = dataManager.loadList(LContextRPDFile);

            for (FileDescriptor itemF:listRPDFile)
            {
                InputStream inputStream = fileLoader.openStream(itemF);

                out.putNextEntry(new ZipEntry(expertiseName + "/" + item.getHeadRPD().getPressmark() + "/" + itemF.getName()));
                WriteInZip(inputStream, out);
                out.close();
            }
        }
*/
    }

    ///Запись в архив
    private  void WriteInZip(InputStream in, OutputStream out) throws IOException
    {
        byte[] buffer = new byte[1024];
        int len;
        while ((len = in.read(buffer)) >= 0)
            out.write(buffer, 0, len);
        in.close();
    }

}