-- begin Global
--Фильтр(Отрезаем ClearValue)
INSERT INTO SYS_CONFIG (ID, VERSION, NAME, VALUE_)
    VALUES ('19516211-4a31-d2dc-97ab-5923ed90cec0','0','cuba.gui.genericFilterControlsLayout', 
            '[filters_popup] [add_condition] [spacer] [settings | save, save_with_values, save_as, edit, remove, make_default, pin, save_search_folder, save_app_folder] [max_results] [fts_switch]');


--Ограничение на загрузку 100            
INSERT INTO SYS_CONFIG (ID, VERSION, NAME, VALUE_)
    VALUES ('40bbc94e-1044-547b-afa3-d13a54eb8a7f','0','cuba.maxUploadSizeMb','100');
-- end


-- begin Scheduled_Task
INSERT INTO sys_scheduled_task(id,bean_name,method_name,is_active,period)
    VALUES ('875dd77e-b863-8fec-e200-dc987870ffc9','cuba_Emailer','processQueuedEmails','t','10');
-- end Scheduled_Task


-- begin Role
-- Создание роли GIP
INSERT INTO sec_role(id,version, name, loc_name, description, role_type)
    VALUES ('b4a71c38-e595-3c4a-5272-b1fe9458289d','0','GIP','ГИП','Роль для ГИП-а с правом работать с Экспертизой, Входящими документами, Справочниками','0');

-- Создание роли Expert
INSERT INTO sec_role(id,version, name, loc_name, description, role_type)
    VALUES ('782bdea3-0886-58b2-06e9-bc0d1ba6040e','0','Expert','Эксперт','Роль с правами доступа для работы с Экспертизой','0');

-- Создание роли Customer
INSERT INTO sec_role(id,version, name, loc_name, description, role_type)
    VALUES ('4c82f733-9d20-b11d-0078-f8e68638948f','0','Customer', 'Заявитель', 'Роль для Заявителей экспертизы с правами для работы с Входящими документами, 
Замечаниями/Ответами на замечания', '30');

-- Создание роли User
INSERT INTO sec_role(id,version, name, loc_name, description, is_default_role, role_type)
    VALUES ('bf7e2920-fa43-f3ae-2779-913dbd0a1764','0','User','Пользователь','Роль по умолчанию с забранными правами', 't','30');
-- end Role


-- report

--end report
INSERT INTO report_report(id, version, name, code, description, group_id, report_type, xml, roles_idx, screens_idx, input_entity_types_idx)
    VALUES ('9bb1292e-ec04-b338-e2d7-bee15abb501e','0','Замечания в работе','Report_3','Отчет с фильтром по не отвеченным по всем экспертизам','4e083530-0b9c-11e1-9b41-6bdaa41bff94','10','{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e","code":"Report_3","roles":[{"metaClass":"sec$Role","id":"782bdea3-0886-58b2-06e9-bc0d1ba6040e","locName":"Эксперт","description":"Роль с правами доступа для работы с Экспертизой","type":"0","version":"0","name":"Expert"},{"metaClass":"sec$Role","id":"b4a71c38-e595-3c4a-5272-b1fe9458289d","locName":"ГИП","description":"Роль для ГИП-а с правом работать с Экспертизой, Входящими документами, Справочниками","type":"0","version":"0","name":"GIP"}],"defaultTemplate":{"metaClass":"report$ReportTemplate","id":"20729dd9-3f74-9520-4326-d541e0660036","code":"DEFAULT","customDefinedBy":"100","custom":"false","version":"1","reportOutputType":"50","customDefinition":"","report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"},"name":"Template_1-3.xlsx","alterable":"false"},"description":"Отчет с фильтром по не отвеченным по всем экспертизам","bands":[{"metaClass":"report$BandDefinition","id":"72085370-ee91-12a0-c168-d35d5c6a4982","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"72845b03-7740-156c-7861-f09bfdd501eb","orientation":"0","childrenBandDefinitions":[],"name":"Remark","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"72085370-ee91-12a0-c168-d35d5c6a4982"},"report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"},"dataSets":[{"metaClass":"report$DataSet","id":"c77af3ca-0e33-7c99-e4c4-b6734ed17cdd","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"72845b03-7740-156c-7861-f09bfdd501eb"},"text":"SELECT ra.remark AS \"remark\", ra.answer AS \"answer\",\nCASE WHEN ra.is_fixed \u003d true THEN \u0027Устранено\u0027 \nELSE \u0027Не устранено\u0027 END AS \"fixed\"\nFROM daex_remark_answer ra\nJOIN daex_rpd_file rf ON rf.id \u003d ra.rpd_file_id\nWHERE rf.rpd_id \u003d ${RPD.rpd_id} AND ra.Answer IS NULL","view":"null"}],"position":"0"}],"name":"RPD","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"5e829f08-f0a1-435f-7f38-f1189440f7aa","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"72085370-ee91-12a0-c168-d35d5c6a4982"}],"name":"Expertise","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"76dc301b-485d-7b51-6434-e236cb2e2491","orientation":"","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"5e829f08-f0a1-435f-7f38-f1189440f7aa"}],"name":"Root","report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"},"dataSets":[],"position":"0"},"report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"},"dataSets":[{"metaClass":"report$DataSet","id":"7019d8be-280d-db74-df26-19ea6f29a418","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"5e829f08-f0a1-435f-7f38-f1189440f7aa"},"text":"SELECT e.subject_name AS \"ex_subjectName\", e.pressmark AS \"ex_pressmark\",\ne.id AS \"ex_id\"\nFROM daex_expertise e","view":"null"}],"position":"0"},"report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"},"dataSets":[{"metaClass":"report$DataSet","id":"80000fe1-a290-ba75-8f56-cda3b0887c19","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"72085370-ee91-12a0-c168-d35d5c6a4982"},"text":"SELECT rpd.id AS \"rpd_id\", rpd.pressmark AS \"rpd_pressmark\"\nFROM daex_rpd rpd\nWHERE rpd.expertise_rpd_id \u003d ${Expertise.ex_id}","view":"null"}],"position":"0"},{"metaClass":"report$BandDefinition","id":"76dc301b-485d-7b51-6434-e236cb2e2491"},{"metaClass":"report$BandDefinition","id":"5e829f08-f0a1-435f-7f38-f1189440f7aa"},{"metaClass":"report$BandDefinition","id":"72845b03-7740-156c-7861-f09bfdd501eb"}],"inputParameters":[],"validationOn":"false","reportType":"10","reportScreens":[{"metaClass":"report$ReportScreen","id":"875593ca-ec6c-cf95-5fb0-c8785b9834e3","screenId":"daex$Expertise.browse","report":{"metaClass":"report$Report","id":"9bb1292e-ec04-b338-e2d7-bee15abb501e"}}],"screensIdx":",daex$Expertise.browse,","group":{"metaClass":"report$ReportGroup","id":"4e083530-0b9c-11e1-9b41-6bdaa41bff94","localeNames":"en\u003dGeneral\nru\u003dОбщие","code":"ReportGroup.default","title":"General","version":"0"},"valuesFormats":[],"templates":[{"metaClass":"report$ReportTemplate","id":"20729dd9-3f74-9520-4326-d541e0660036"}],"rolesIdx":",782bdea3-0886-58b2-06e9-bc0d1ba6040e,b4a71c38-e595-3c4a-5272-b1fe9458289d,","version":"2","name":"Замечания в работе"}',',782bdea3-0886-58b2-06e9-bc0d1ba6040e,b4a71c38-e595-3c4a-5272-b1fe9458289d,',',daex$Expertise.browse,','');
INSERT INTO report_report(id, version, name, code, description, group_id, report_type, xml, roles_idx, screens_idx, input_entity_types_idx)
    VALUES ('ab3ea750-a1a2-5953-9c90-a64a7452e344','0','Сводные замечания','Report_1','Отчет с фильтром по одной экспертизе всех замечаний','4e083530-0b9c-11e1-9b41-6bdaa41bff94','10','{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344","code":"Report_1","roles":[{"metaClass":"sec$Role","id":"782bdea3-0886-58b2-06e9-bc0d1ba6040e","locName":"Эксперт","description":"Роль с правами доступа для работы с Экспертизой","type":"0","version":"0","name":"Expert"},{"metaClass":"sec$Role","id":"b4a71c38-e595-3c4a-5272-b1fe9458289d","locName":"ГИП","description":"Роль для ГИП-а с правом работать с Экспертизой, Входящими документами, Справочниками","type":"0","version":"0","name":"GIP"},{"metaClass":"sec$Role","id":"4c82f733-9d20-b11d-0078-f8e68638948f","locName":"Заявитель","description":"Роль для Заявителей экспертизы с правами для работы с Входящими документами, \r\nЗамечаниями/Ответами на замечания","type":"30","version":"0","name":"Customer"}],"defaultTemplate":{"metaClass":"report$ReportTemplate","id":"9b4f59f2-a328-911e-846c-cd6a8a3b1e99","code":"DEFAULT","customDefinedBy":"100","custom":"false","version":"1","outputNamePattern":"Отчет с фильтром по одной экспертизе всех замечаний.xlsx","reportOutputType":"50","customDefinition":"","report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"name":"Template_1-3.xlsx","alterable":"false"},"description":"Отчет с фильтром по одной экспертизе всех замечаний","bands":[{"metaClass":"report$BandDefinition","id":"e8579879-89df-b8e6-057d-1f26db7d69b3","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"4371a1d3-f233-0424-df1a-893606a6d579","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"f7391c00-4e50-994a-483e-905a1709e8bc","orientation":"0","childrenBandDefinitions":[],"name":"Remark","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"4371a1d3-f233-0424-df1a-893606a6d579"},"report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"dataSets":[{"metaClass":"report$DataSet","id":"c39102a0-7829-2352-b8b4-794c48f5696e","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"f7391c00-4e50-994a-483e-905a1709e8bc"},"text":"SELECT ra.remark AS \"remark\", ra.answer AS \"answer\",\nCASE WHEN ra.is_fixed \u003d true THEN \u0027Устранено\u0027 \nELSE \u0027Не устранено\u0027 END AS \"fixed\"\nFROM daex_remark_answer ra\nJOIN daex_rpd_file rf ON rf.id \u003d ra.rpd_file_id\nWHERE rf.rpd_id \u003d ${RPD.rpd_id}","view":"null"}],"position":"0"}],"name":"RPD","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"e8579879-89df-b8e6-057d-1f26db7d69b3"},"report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"dataSets":[{"metaClass":"report$DataSet","id":"ec671f53-d63b-702b-a8ab-702fb3d3d14e","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"4371a1d3-f233-0424-df1a-893606a6d579"},"text":"SELECT rpd.id AS \"rpd_id\", rpd.pressmark AS \"rpd_pressmark\"\nFROM daex_rpd rpd\nWHERE rpd.expertise_rpd_id \u003d ${Expertise.ex_id}","view":"null"}],"position":"0"}],"name":"Expertise","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"588b3a05-ff60-62d7-d6a0-d8363c426c72","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"e8579879-89df-b8e6-057d-1f26db7d69b3"}],"name":"Root","report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"dataSets":[],"position":"0"},"report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"dataSets":[{"metaClass":"report$DataSet","id":"de6ddfa4-8d8c-59ce-cfd4-3f73ec759d71","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"e8579879-89df-b8e6-057d-1f26db7d69b3"},"text":"SELECT e.subject_name AS \"ex_subjectName\", e.pressmark AS \"ex_pressmark\",\ne.id AS \"ex_id\"\nFROM daex_expertise e\nWHERE e.id \u003d ${E}","view":"null"}],"position":"0"},{"metaClass":"report$BandDefinition","id":"588b3a05-ff60-62d7-d6a0-d8363c426c72"},{"metaClass":"report$BandDefinition","id":"4371a1d3-f233-0424-df1a-893606a6d579"},{"metaClass":"report$BandDefinition","id":"f7391c00-4e50-994a-483e-905a1709e8bc"}],"inputParameters":[{"metaClass":"report$ReportInputParameter","id":"455151ae-46ab-ff00-a463-6f00de963cf1","entityMetaClass":"daex$Expertise","parameterClassName":"com.company.daex.entity.Expertise","predefinedTransformation":"","type":"30","required":"false","validationOn":"false","defaultDateIsCurrent":"false","report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"},"name":"Экспертиза","alias":"E","position":"0"}],"validationOn":"false","reportType":"10","reportScreens":[{"metaClass":"report$ReportScreen","id":"ab3eb6ed-e360-84b3-2829-80a0273d07d4","screenId":"daex$Expertise.browse","report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"}},{"metaClass":"report$ReportScreen","id":"57e6198a-75a2-ddf2-4e88-a51a6cea0c08","screenId":"daex$ExpertiseCustomer.browse","report":{"metaClass":"report$Report","id":"ab3ea750-a1a2-5953-9c90-a64a7452e344"}}],"screensIdx":",daex$Expertise.browse,daex$ExpertiseCustomer.browse,","group":{"metaClass":"report$ReportGroup","id":"4e083530-0b9c-11e1-9b41-6bdaa41bff94","localeNames":"en\u003dGeneral\nru\u003dОбщие","code":"ReportGroup.default","title":"General","version":"0"},"inputEntityTypesIdx":",daex$Expertise,","valuesFormats":[],"templates":[{"metaClass":"report$ReportTemplate","id":"9b4f59f2-a328-911e-846c-cd6a8a3b1e99"}],"rolesIdx":",782bdea3-0886-58b2-06e9-bc0d1ba6040e,b4a71c38-e595-3c4a-5272-b1fe9458289d,4c82f733-9d20-b11d-0078-f8e68638948f,","version":"2","name":"Сводные замечания"}',',782bdea3-0886-58b2-06e9-bc0d1ba6040e,b4a71c38-e595-3c4a-5272-b1fe9458289d,4c82f733-9d20-b11d-0078-f8e68638948f,',',daex$Expertise.browse,daex$ExpertiseCustomer.browse,',',daex$Expertise,');
INSERT INTO report_report(id, version, name, code, description, group_id, report_type, xml, roles_idx, screens_idx, input_entity_types_idx)
    VALUES ('64c95d72-e078-de16-c56a-7a2ba5c94dfd','0','Актуальные замечания','Report_2','Отчет с фильтром по не отвеченным по одной экспертизе','4e083530-0b9c-11e1-9b41-6bdaa41bff94','10','{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd","code":"Report_2","roles":[{"metaClass":"sec$Role","id":"782bdea3-0886-58b2-06e9-bc0d1ba6040e","locName":"Эксперт","description":"Роль с правами доступа для работы с Экспертизой","type":"0","version":"0","name":"Expert"},{"metaClass":"sec$Role","id":"4c82f733-9d20-b11d-0078-f8e68638948f","locName":"Заявитель","description":"Роль для Заявителей экспертизы с правами для работы с Входящими документами, \r\nЗамечаниями/Ответами на замечания","type":"30","version":"0","name":"Customer"},{"metaClass":"sec$Role","id":"b4a71c38-e595-3c4a-5272-b1fe9458289d","locName":"ГИП","description":"Роль для ГИП-а с правом работать с Экспертизой, Входящими документами, Справочниками","type":"0","version":"0","name":"GIP"}],"defaultTemplate":{"metaClass":"report$ReportTemplate","id":"ade805db-63c8-9fe2-ddd6-e0fca4afe6ab","code":"DEFAULT","customDefinedBy":"100","custom":"false","version":"1","outputNamePattern":"Отчет с фильтром по не отвеченным по одной экспертизе.xlsx","reportOutputType":"50","customDefinition":"","report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"name":"Template_1-3.xlsx","alterable":"false"},"description":"Отчет с фильтром по не отвеченным по одной экспертизе","bands":[{"metaClass":"report$BandDefinition","id":"8ad7b00b-202c-5239-4f1e-40ef7ef8dd35","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"a8a7c8da-9dda-4bf5-f23b-f16839c8249a","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"023ef45a-76d2-f4fb-040d-75eb22cb3f69","orientation":"0","childrenBandDefinitions":[],"name":"Remark","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"a8a7c8da-9dda-4bf5-f23b-f16839c8249a"},"report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"dataSets":[{"metaClass":"report$DataSet","id":"b61fb62c-aa8b-11b6-793a-3a466d70eb56","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"023ef45a-76d2-f4fb-040d-75eb22cb3f69"},"text":"SELECT ra.remark AS \"remark\", ra.answer AS \"answer\",\nCASE WHEN ra.is_fixed \u003d true THEN \u0027Устранено\u0027 \nELSE \u0027Не устранено\u0027 END AS \"fixed\"\nFROM daex_remark_answer ra\nJOIN daex_rpd_file rf ON rf.id \u003d ra.rpd_file_id\nWHERE rf.rpd_id \u003d ${RPD.rpd_id} AND ra.Answer IS NULL","view":"null"}],"position":"0"}],"name":"RPD","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"8ad7b00b-202c-5239-4f1e-40ef7ef8dd35"},"report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"dataSets":[{"metaClass":"report$DataSet","id":"18c07a6f-d865-a6dd-0fe0-10a260596768","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"a8a7c8da-9dda-4bf5-f23b-f16839c8249a"},"text":"SELECT rpd.id AS \"rpd_id\", rpd.pressmark AS \"rpd_pressmark\"\nFROM daex_rpd rpd\nWHERE rpd.expertise_rpd_id \u003d ${Expertise.ex_id}","view":"null"}],"position":"0"}],"name":"Expertise","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"723e3f9e-539e-374e-a5c7-716a75f9408b","orientation":"","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"8ad7b00b-202c-5239-4f1e-40ef7ef8dd35"}],"name":"Root","report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"dataSets":[],"position":"0"},"report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"dataSets":[{"metaClass":"report$DataSet","id":"4f0ec57d-7c49-83b7-bd1d-fd764de60023","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"8ad7b00b-202c-5239-4f1e-40ef7ef8dd35"},"text":"SELECT e.subject_name AS \"ex_subjectName\", e.pressmark AS \"ex_pressmark\",\ne.id AS \"ex_id\"\nFROM daex_expertise e\nWHERE e.id \u003d ${E}","view":"null"}],"position":"0"},{"metaClass":"report$BandDefinition","id":"723e3f9e-539e-374e-a5c7-716a75f9408b"},{"metaClass":"report$BandDefinition","id":"a8a7c8da-9dda-4bf5-f23b-f16839c8249a"},{"metaClass":"report$BandDefinition","id":"023ef45a-76d2-f4fb-040d-75eb22cb3f69"}],"inputParameters":[{"metaClass":"report$ReportInputParameter","id":"166ec5bc-be92-0eb1-0612-4699044aa172","entityMetaClass":"daex$Expertise","parameterClassName":"com.company.daex.entity.Expertise","predefinedTransformation":"","type":"30","required":"false","validationOn":"false","defaultDateIsCurrent":"false","report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"},"name":"Экспертиза","alias":"E","position":"0"}],"validationOn":"false","reportType":"10","reportScreens":[{"metaClass":"report$ReportScreen","id":"e84991ab-9c47-a2ed-e95c-ad836bc9943f","screenId":"daex$Expertise.browse","report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"}},{"metaClass":"report$ReportScreen","id":"1e3d79dc-763e-0ce7-98af-6576e900f152","screenId":"daex$ExpertiseCustomer.browse","report":{"metaClass":"report$Report","id":"64c95d72-e078-de16-c56a-7a2ba5c94dfd"}}],"screensIdx":",daex$Expertise.browse,daex$ExpertiseCustomer.browse,","group":{"metaClass":"report$ReportGroup","id":"4e083530-0b9c-11e1-9b41-6bdaa41bff94","localeNames":"en\u003dGeneral\nru\u003dОбщие","code":"ReportGroup.default","title":"General","version":"0"},"inputEntityTypesIdx":",daex$Expertise,","valuesFormats":[],"templates":[{"metaClass":"report$ReportTemplate","id":"ade805db-63c8-9fe2-ddd6-e0fca4afe6ab"}],"rolesIdx":",782bdea3-0886-58b2-06e9-bc0d1ba6040e,4c82f733-9d20-b11d-0078-f8e68638948f,b4a71c38-e595-3c4a-5272-b1fe9458289d,","version":"2","name":"Актуальные замечания"}',',782bdea3-0886-58b2-06e9-bc0d1ba6040e,4c82f733-9d20-b11d-0078-f8e68638948f,b4a71c38-e595-3c4a-5272-b1fe9458289d,',',daex$Expertise.browse,daex$ExpertiseCustomer.browse,',',daex$Expertise,');
INSERT INTO report_report(id, version, name, code, description, group_id, report_type, xml, roles_idx, screens_idx, input_entity_types_idx)
    VALUES ('ab658f86-2995-745f-10dc-d0a9130d2398','0','Рапорт руководителю','Report_4','Сводка для руководителя по всем экспертизам','4e083530-0b9c-11e1-9b41-6bdaa41bff94','10','{"metaClass":"report$Report","id":"ab658f86-2995-745f-10dc-d0a9130d2398","code":"Report_4","roles":[],"defaultTemplate":{"metaClass":"report$ReportTemplate","id":"9fb5755a-f6cc-3215-6015-bc32d401c9c8","code":"DEFAULT","customDefinedBy":"100","custom":"false","version":"1","outputNamePattern":"Сводка для руководителя по всем экспертизам.xlsx","reportOutputType":"50","customDefinition":"","report":{"metaClass":"report$Report","id":"ab658f86-2995-745f-10dc-d0a9130d2398"},"name":"Template_4.xlsx","alterable":"false"},"description":"Сводка для руководителя по всем экспертизам","bands":[{"metaClass":"report$BandDefinition","id":"8283679c-6941-7f93-fca9-c5fa9be63309","orientation":"","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"90b45ec4-32a6-80f0-01cc-eef892694241","orientation":"0","childrenBandDefinitions":[{"metaClass":"report$BandDefinition","id":"c5413c86-3150-977f-4418-91367c316055","orientation":"0","childrenBandDefinitions":[],"name":"Remark","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"90b45ec4-32a6-80f0-01cc-eef892694241"},"report":{"metaClass":"report$Report","id":"ab658f86-2995-745f-10dc-d0a9130d2398"},"dataSets":[{"metaClass":"report$DataSet","id":"d1d4d4f7-97ab-2ab1-7422-506d23609579","type":"10","jsonSourceType":"10","name":"one_Total","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"c5413c86-3150-977f-4418-91367c316055"},"text":"SELECT COUNT(ra.id) AS \"ra_Total\"\nFROM daex_remark_answer ra\nJOIN daex_rpd_file rf ON rf.id \u003d ra.rpd_file_id\nJOIN daex_rpd rpd ON rpd.id \u003d rf.rpd_id\nWHERE rpd.expertise_rpd_id \u003d ${Expertise.ex_id}","view":"null"},{"metaClass":"report$DataSet","id":"b3bafa94-f919-4140-2ec8-ef341b2af005","type":"10","jsonSourceType":"10","name":"two_isNULL","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"c5413c86-3150-977f-4418-91367c316055"},"text":"SELECT COUNT(ra.id) AS \"ra_isNULL\"\nFROM daex_remark_answer ra\nJOIN daex_rpd_file rf ON rf.id \u003d ra.rpd_file_id\nJOIN daex_rpd rpd ON rpd.id \u003d rf.rpd_id\nWHERE rpd.expertise_rpd_id \u003d ${Expertise.ex_id} AND ra.Answer IS NULL","view":"null"}],"position":"0"}],"name":"Expertise","parentBandDefinition":{"metaClass":"report$BandDefinition","id":"8283679c-6941-7f93-fca9-c5fa9be63309"},"report":{"metaClass":"report$Report","id":"ab658f86-2995-745f-10dc-d0a9130d2398"},"dataSets":[{"metaClass":"report$DataSet","id":"98ecd0d0-0f41-43b6-e3b1-34381cb6ded4","type":"10","jsonSourceType":"10","name":"one","useExistingView":"false","bandDefinition":{"metaClass":"report$BandDefinition","id":"90b45ec4-32a6-80f0-01cc-eef892694241"},"text":"SELECT e.subject_name AS \"ex_subjectName\", e.pressmark AS \"ex_pressmark\",\ne.id AS \"ex_id\"\nFROM daex_expertise e","view":"null"}],"position":"0"}],"name":"Root","report":{"metaClass":"report$Report","id":"ab658f86-2995-745f-10dc-d0a9130d2398"},"dataSets":[],"position":"0"},{"metaClass":"report$BandDefinition","id":"c5413c86-3150-977f-4418-91367c316055"},{"metaClass":"report$BandDefinition","id":"90b45ec4-32a6-80f0-01cc-eef892694241"}],"inputParameters":[],"validationOn":"false","reportType":"10","reportScreens":[],"group":{"metaClass":"report$ReportGroup","id":"4e083530-0b9c-11e1-9b41-6bdaa41bff94","localeNames":"en\u003dGeneral\nru\u003dОбщие","code":"ReportGroup.default","title":"General","version":"0"},"valuesFormats":[],"templates":[{"metaClass":"report$ReportTemplate","id":"9fb5755a-f6cc-3215-6015-bc32d401c9c8"}],"version":"2","name":"Рапорт руководителю"}','','','');
-- end Global

-- begin Permission
-- Разрешение доступа к экранам для Анонима        
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c57d75c2-89f6-e5cc-638a-52e3a720a670','0','10','registration','1','cd541dd4-eeb7-cd5b-847e-d32236552fa9');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('26b155a0-6755-d71b-0efc-67321e2d1359','0','10','verification','1','cd541dd4-eeb7-cd5b-847e-d32236552fa9');
--end


-- User
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('a28a6b27-5006-90f9-fe3d-8fad3d81d43e','0','50','daex$RemarkAnswer.edit:buttonFixed','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('448314aa-007c-a4d1-6a4a-81c8bb7cc98a','0','50','daex$RPDFile.edit:buttonFinalVersion','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('33f412c7-a527-3c27-dac9-784f5df32ea6','0','50','daex$RemarkAnswer.edit:buttonAdd','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f1d3440a-3a4f-c60a-0adb-5e209b33549f','0','50','daex$RemarkAnswer.edit:buttonRemove','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('45e06c76-14fc-5424-b2c3-0141c44e25bf','0','50','daex$RemarkAnswer.edit:multiUpload','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('8dd63c65-f79d-3a78-d90a-54bb805718dd','0','50','daex$RemarkAnswer.edit:buttonUnload','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('ba3111f3-cad0-c420-41f3-cbb0a7418032','0','50','daex$ExpertiseCustomer.browse:buttonReport_1','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('8f95c9c7-0c4c-abdf-860c-432cc4f7b66b','0','50','daex$Expertise.browse:buttonReport_2','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('6a93aecc-e840-5a48-45c6-7729467fac1c','0','50','daex$Expertise.browse:buttonReport_3','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('6288bd1a-c3cd-f950-3632-2a76f792550d','0','50','daex$ExpertiseCustomer.browse:buttonReport_2','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('0a8f3a03-43b6-9e12-110f-6ab43bb47153','0','50','daex$Expertise.browse:buttonReport_1','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('322a21d1-9622-36fc-6918-cd909c17016f','0','50','daex$Expertise.browse:buttonReport_4','0','bf7e2920-fa43-f3ae-2779-913dbd0a1764');

-- end User


-- GIP

-- Настройка Экраны
-- Меню
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5f25cdba-73ab-edb6-f992-fbd56b7003cc','0','10','documents','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('6602d745-c53a-6423-3a0a-45762c7d7ac0','0','10','inbox','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e7a22631-328e-0790-7e09-b0c02ca8c49b','0','10','expertises','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('99d9acaf-af96-e5e5-29e5-2146057f3d96','0','10','directories','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d6952a94-803a-16c5-eade-371d6505bd3a','0','10','systemDirectories','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');

-- Экраны
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('6eb53293-23ae-4b15-7795-0ca7840ee00c','0','10','daex$IncomingDocument.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('50d46fa2-63aa-51d9-91e4-aba8c05e1d84','0','10','daex$IncomingDocument.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f32015a4-6a49-069f-e946-04568fda91a2','0','10','daex$Expertise.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('1b9c4941-fad5-1f64-f3de-1b91d07bf5fd','0','10','daex$Expertise.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c1bf4f40-35fb-e55e-2c74-09ac9ec3600b','0','10','daex$RPD.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('ed2b9fd4-5d01-a73d-9163-617cf80ce74f','0','10','daex$RPD.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('42c19d9e-8568-becd-09da-4347e946e89c','0','10','daex$RPDFile.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('934bfee1-01df-29aa-30cc-92b8c3e1d774','0','10','daex$RPDFile.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('ec6faab7-9143-4c46-7314-551941cfa316','0','10','daex$RemarkAnswer.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('85dc8e58-6000-5aad-af3c-0a3b1a3de2db','0','10','daex$RemarkAnswer.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('2b3b6c03-00dd-447a-955c-b12fb8e013a4','0','10','daex$AccessSettings.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('96d42401-4ab8-2532-76b8-8ecef0cba32d','0','10','daex$Customer.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('87a990f8-1141-3d39-0c8c-c09b30ba3942','0','10','daex$Customer.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b5b9ebb1-f100-cacf-22ea-1e549ee464bf','0','10','daex$Employee.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('cb70924a-40a4-29fe-dd4d-e6f18a315154','0','10','daex$HeadRPD.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('672c021d-0827-2d29-b270-944a4cd734fd','0','10','daex$Certificate.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('523a4687-8378-4366-3400-995c8804a2c4','0','10','saveFilter','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b449166f-af6a-f2cf-2ac5-8790a11bfb49','0','10','filterEditor','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f527ec6f-80f3-06fe-9015-1b0ddeabc2e9','0','10','filterSelect','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f24c6bc7-e225-075c-f9e8-fba8eff594e9','0','10','fileUploadDialog','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('0935104b-2ce6-bb13-2a76-64c2081e0ba3','0','10','sys$FileDescriptor.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('36a46e32-60af-2d38-1679-40a89b2aa4ec','0','10','daex$IncomingDocumentFileDescriptor.browse','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4ef1a2d2-afe5-f27e-45e2-dbb8e4d1264f','0','10','list-editor-popup','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');

-- Настройка Сущности

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('a7d6f088-af92-783a-901f-1d33439af4ea','0','20','daex$IncomingDocument:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('292084e7-21c3-bf03-5ae0-c0209268dc93','0','20','daex$IncomingDocument:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5a55909c-0016-44c9-9cd3-273d28a79410','0','20','daex$IncomingDocument:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d1d140d2-4246-74e2-3aab-b1c8d50b46a2','0','20','daex$IncomingDocument:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e107f337-a97a-0702-a61e-f50db118d036','0','20','daex$Expertise:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f84d7d8a-b443-e87d-1833-fd4e2833753d','0','20','daex$Expertise:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3c4a38eb-5ed0-7a09-53ac-6fc8fd9229c6','0','20','daex$Expertise:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('01faa748-4005-c5c7-5421-c2291ef7599b','0','20','daex$Expertise:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('243d0c38-886c-3eb8-7486-4c0f55f5f71b','0','20','daex$RPD:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('afb773c4-e8c4-ad8f-3345-029260da9a1a','0','20','daex$RPD:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b09f9839-05b2-66f1-8e6f-70400c3ccae0','0','20','daex$RPD:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3ef73745-5c3f-f72d-5577-c4f53360ef62','0','20','daex$RPD:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('95e04a8c-e299-bb52-ee2d-ce3a51427354','0','20','daex$RPDFile:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('79fcba60-701c-407d-df98-f9fdb89e43e0','0','20','daex$RPDFile:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d0eba794-453a-9f61-c2cd-9c7f3c933b6c','0','20','daex$RPDFile:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('2f365dbd-b922-9de0-7b52-2c6cec79522a','0','20','daex$RPDFile:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('95f7f261-7c48-d6f5-b02e-4f0e962880c2','0','20','daex$RemarkAnswer:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e83504b9-4998-12e9-add2-950fb04bab06','0','20','daex$RemarkAnswer:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c2593570-bdd2-5d1d-f2f4-efe2e15f74f4','0','20','daex$RemarkAnswer:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d2868d08-1eee-49d9-9451-8b05407189e8','0','20','daex$RemarkAnswer:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9f1fb533-1e6f-9d83-f2ed-fb20bb337efa','0','20','daex$AccessSettings:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c0fe418b-ec94-72c9-4183-a61f08f0b485','0','20','daex$AccessSettings:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4d0764d8-e3de-a9fc-5448-b677e31e297a','0','20','daex$AccessSettings:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e96e688f-ed35-4c2d-0f98-c2f68824ec00','0','20','daex$AccessSettings:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('71490cd9-7d41-7bdb-4d00-c67ad83e6578','0','20','daex$Customer:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c9e57fdf-08b1-b31e-e735-8bf7c27edc48','0','20','daex$Customer:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('ef9030c8-73d9-54f8-4dbc-797403d26111','0','20','daex$Customer:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('dda294b4-d893-208e-2bd8-6f57825cdac2','0','20','daex$Customer:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('db49a09b-e001-71a7-3409-f7b3daced36c','0','20','daex$Employee:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5dd69ded-0243-8837-25a8-36d4ed8ef43c','0','20','daex$HeadRPD:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5c127091-b69a-7f52-1877-94ea3644b82e','0','20','daex$Certificate:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('0c66ebf6-26f5-76d3-d38d-0b8f379aeebb','0','20','sys$FileDescriptor:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('77707fef-1066-a017-eed6-b815a881e3d4','0','20','sys$FileDescriptor:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('07c06dad-efeb-5ba9-2db4-8373fb980463','0','20','sys$FileDescriptor:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('a25d6a15-b557-708f-2668-9a4c0f89732d','0','20','sys$FileDescriptor:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('db25cd29-7d21-14c5-3964-6b5e507d2b2f','0','20','sec$Filter:create','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('a3a2fc78-26a6-076f-24ea-ddb857e40d11','0','20','sec$Filter:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('261a53e1-460a-909d-1e6d-af417c5c0df6','0','20','sec$Filter:update','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9151c58f-001f-afa3-0fe5-ecdb1ac73be7','0','20','sec$Filter:delete','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('37e41254-7b10-5e70-b2f6-125277a9df87','0','20','sec$User:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('56b5f821-1c4a-044e-f149-7646eee76e13','0','20','report$Report:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('915ad57b-af53-5115-68ee-398c5d10a844','0','20','daex$IncomingDocumentFileDescriptor:read','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');

-- Настройка Атрибуты

-- Настройка Специфичные
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('84622756-f2b2-c6a6-95b4-f77a471146d3','0','40','cuba.gui.filter.edit','1','b4a71c38-e595-3c4a-5272-b1fe9458289d');

-- Настройка Интерфейс
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('de21b179-592a-e0f7-dae0-ad2d78f2b889','0','50','daex$RPDFile.edit:buttonFinalVersion','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('1cd56d9a-822e-158b-05e0-8ac3c74773f1','0','50','daex$Expertise.browse:buttonReport_4','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('7dd371fa-0282-1f68-f63d-1e8ec79891ad','0','50','daex$Expertise.browse:buttonReport_3','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('dbfdb65f-aac5-24ea-e685-b615d04b0a2a','0','50','daex$Expertise.browse:buttonReport_1','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('71660096-8ff1-f040-9075-2f6e1e6780a3','0','50','daex$Expertise.browse:buttonReport_2','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e2519f1b-877f-32ca-cf3b-1c504d99acda','0','50','daex$RemarkAnswer.edit:buttonUnload','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('eaf9016b-6632-a53c-d83b-ec93c16120f0','0','50','daex$RemarkAnswer.edit:buttonAdd','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f325b7bf-aedd-68f2-7e85-28e797d19c22','0','50','daex$RemarkAnswer.edit:multiUpload','2','b4a71c38-e595-3c4a-5272-b1fe9458289d');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9e738ff8-ce2a-66ae-0ca5-0beb0c8c1fd0','0','50','daex$RemarkAnswer.edit:multiUpload','2','4c82f733-9d20-b11d-0078-f8e68638948f');

-- end GIP


-- Expert

-- Настройка Экраны
-- Меню
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b66c5987-19fe-67f0-3e23-f5fbea8c58b0','0','10','expertises','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
-- Экраны
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9e229f56-84c8-4ab5-e71a-68ee7765f607','0','10','daex$Expertise.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('042eaff6-ea44-f71a-3b61-51dabbcf282c','0','10','daex$Expertise.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('334ad9c0-f1e1-6947-8767-0a67f2ac5ff5','0','10','daex$RPD.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('55f9c74f-a676-0be0-862e-65823b92b03b','0','10','daex$RPD.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('0f3aa9f3-c27e-f001-7c40-0c03e3a79f4d','0','10','daex$RPDFile.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('916102e4-2779-218d-e6a3-c9718c3094ad','0','10','daex$RPDFile.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3f3cda67-ced2-b459-d2e1-4c5cdb320196','0','10','daex$RemarkAnswer.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3c86ded9-0a48-1f2c-802b-d28b5c84e434','0','10','daex$RemarkAnswer.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('7ec824cb-a07d-d263-d032-ea9da843e1a3','0','10','filterSelect','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e303ac74-59a1-e908-8f31-9293c034e4d7','0','10','saveFilter','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b070d319-83b9-0177-8311-be79d8b6d7a7','0','10','filterEditor','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('58fed000-0cfd-1a7f-1751-1ae8785a00b0','0','10','fileUploadDialog','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4bb52bad-abf7-1b23-4b48-826c960c983d','0','10','sys$FileDescriptor.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d2c0afc7-ca29-e317-ba00-a72ed5773105','0','10','sys$FileDescriptor.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c4ff5680-d250-3fb1-9a6c-d7bfe945dd30','0','10','daex$IncomingDocumentFileDescriptor.browse','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

-- Настройка Сущности
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f1a0228b-1aad-c68e-e42a-60e514554e7e','0','20','daex$Expertise:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('97d74fd0-eda9-5c82-3e0f-c79680168974','0','20','daex$RPD:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d9e8f89e-bb7f-2008-5cf7-1f3e15df213a','0','20','daex$RPDFile:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('2be40103-51c2-194d-bf9c-8ac34373b2d0','0','20','daex$RemarkAnswer:create','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('51f521df-9374-2952-b8fc-7f647050f5b8','0','20','daex$RemarkAnswer:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('063f4b7f-787d-7097-b154-395f22f8989a','0','20','daex$RemarkAnswer:update','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c11ae323-696a-bea1-694d-1a9af1b7c686','0','20','daex$RemarkAnswer:delete','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('7f2e4af7-f510-fb80-ba99-2f1613f31661','0','20','sys$FileDescriptor:create','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f6b22b95-15a0-9fd6-bf41-0f746a4ae574','0','20','sys$FileDescriptor:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('362311e3-a282-312b-d4d2-b958cdab12b4','0','20','sys$FileDescriptor:update','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b60577c4-6ad5-15c1-7df3-9360cf0fd79e','0','20','sys$FileDescriptor:delete','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f7cfe2e4-d7aa-0c9f-f300-c137185a5d89','0','20','sec$Filter:create','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('7d28ab1c-d800-a7bd-2ed5-4a9c8bd3cfcf','0','20','sec$Filter:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('0c250b63-ce51-5e65-61bc-7cca505333a0','0','20','sec$Filter:update','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('67147227-ec36-e899-5575-25f80fda5d37','0','20','sec$Filter:delete','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');



INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3f8a475d-119b-5bd8-35e4-13ef1cf62de4','0','20','report$Report:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9fb6bd3e-b379-9e8c-1e82-70d281fe1ece','0','20','daex$IncomingDocumentFileDescriptor:read','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

-- Настройка Атрибуты
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('1d383adc-455a-a2f2-d281-fc6b26fba31b','0','30','daex$RemarkAnswer:answer','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

-- Настройка Специфичные
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('84622756-f2b2-c6a6-95b4-f77a471146d4','0','40','cuba.gui.filter.edit','1','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

-- Настройка Интерфейс
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b2dc1bce-a09b-8c81-872a-23cf2617c043','0','50','daex$RemarkAnswer.edit:multiUpload','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b44983dd-bf0a-8441-c6ea-895c37b35d33','0','50','daex$RemarkAnswer.edit:buttonAdd','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('af9103ec-0b2b-cba8-fdd7-a50c17b94cb2','0','50','daex$RemarkAnswer.edit:buttonUnload','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('81f933f2-3038-ee33-903f-12cb9bbeaf12','0','50','daex$RemarkAnswer.edit:buttonRemove','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3c6f73a5-046a-02ee-654f-b297c4cea04e','0','50','daex$RemarkAnswer.edit:buttonFixed','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('8c3508df-86f0-2cb3-0369-a4346445a7aa','0','50','daex$Expertise.browse:buttonReport_2','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f93eefe7-f9eb-1de2-cf65-599cb1681492','0','50','daex$Expertise.browse:buttonReport_3','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('2cfc71a9-c45d-0fb9-0f6e-fc1120dc1523','0','50','daex$Expertise.browse:buttonReport_1','2','782bdea3-0886-58b2-06e9-bc0d1ba6040e');

-- end Expert


-- Customer

-- Настройка Экраны
-- Меню
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('9c348382-53c5-7ace-e33d-fe5051cc15b5','0','10','documents','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('cacc8e23-8912-0b99-68e5-42587489f975','0','10','outbox','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('aee2373a-cb98-09e7-80ec-954d9d649444','0','10','expertises','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('8aeb6075-df3d-e4f0-34b0-964aa475fba6','0','10','help','1','4c82f733-9d20-b11d-0078-f8e68638948f');

-- Экраны 
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('89ed5992-854e-b630-168d-cb4eb2bb0b89','0','10','daex$IncomingDocumentCustomer.browse','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('df42ab27-6524-3362-ed6e-5184d2e38b14','0','10','daex$IncomingDocumentCustomer.edit','1','4c82f733-9d20-b11d-0078-f8e68638948f');            


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f07bbe33-a3f8-b73f-2a17-b738eea7e8c4','0','10','daex$ExpertiseCustomer.browse','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e425cef3-79ca-8203-5a5f-8d95a3a9e335','0','10','daex$ExpertiseCustomer.edit','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f708e49e-ff21-92d2-7a68-2fd4e127bfe1','0','10','daex$RemarkAnswer.edit','1','4c82f733-9d20-b11d-0078-f8e68638948f');            


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('753ad5c6-0d55-8f83-6554-c03fb4bac264','0','10','aboutWindow','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3780b90b-cbcd-b74b-059f-0da0fc9f274c','0','10','sys$FileDescriptor.edit','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('a2f95613-c303-6ccf-ceb3-523839390159','0','10','fileUploadDialog','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('283dd82c-0f46-6a0d-27e6-d7b2d342b6c9','0','10','multiuploadDialog','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('268eaa77-2fac-c824-ff15-05444704e969','0','10','saveFilter','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('2e1b891d-00a8-cfa5-33fb-eb6b6aa3ec01','0','10','filterEditor','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('646d58c2-c622-f34e-015a-ed455a37ae10','0','10','filterSelect','1','4c82f733-9d20-b11d-0078-f8e68638948f');
            
-- Настройка Сущности
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4f8df88a-3dd8-ec6a-fa8b-59d3802ab88a','0','20','daex$IncomingDocument:create','1','4c82f733-9d20-b11d-0078-f8e68638948f');            
INSERT INTO sec_permission( id, version, permission_type, target, value_, role_id)
    VALUES ('4fdf2d32-ea48-f8e4-0b15-461cf1fd093e','0','20','daex$IncomingDocument:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c5605549-57c8-fd2e-3013-e5e78156a889','0','20','daex$Expertise:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b61aab92-a54e-db6c-4344-dffb925dcdda','0','20','daex$RPD:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');          
            
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('7fc74303-5797-8758-fb18-e5afb89a27e1','0','20','daex$RPDFile:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');
    

            
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('487f2396-b555-5042-921c-1b39f8b762f5','0','20','daex$RemarkAnswer:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('f21db19b-9812-c8fa-dd08-2ceb2ad3eba8','0','20','daex$RemarkAnswer:update','1','4c82f733-9d20-b11d-0078-f8e68638948f');           
            

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e285f349-5181-3e13-374c-9275c29e492f','0','20','sys$FileDescriptor:create','1','4c82f733-9d20-b11d-0078-f8e68638948f');            
 INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('e961f8e0-abc2-15de-2446-ca5bf989d9aa','0','20','sys$FileDescriptor:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');
            

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5a773709-a24f-8641-7604-9665122d64b1','0','20','sec$Filter:create','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('ec2bd2fd-eb2c-75b0-2ada-aa85625ca95d','0','20','sec$Filter:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4a4f57da-45b7-4341-a86a-2716460f4e88','0','20','sec$Filter:update','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('4ceede98-732e-afbe-d881-41da5c4b31e3','0','20','sec$Filter:delete','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c20f0ec7-51e1-91eb-425e-c2df7f92d2c4','0','20','report$Report:read','1','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c426f6ee-bf5f-65eb-a532-e25174278f70','0','20','daex$IncomingDocumentFileDescriptor:create','1','4c82f733-9d20-b11d-0078-f8e68638948f');

-- Настройка Атрибуты
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('1d1eae7c-4cd4-a221-f9cb-7940cc33f32b','0','30','daex$IncomingDocument:createTs','1','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b3ff9790-2fe7-90d4-ef3e-7c11b3098ef7','0','30','daex$IncomingDocument:updateTs','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('dc6c8ad9-c8f4-e3cd-19ad-ef68f9b9d0e7','0','30','daex$IncomingDocument:deletedBy','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('5cc58364-0892-e39a-23dd-ed47e80ab024','0','30','daex$IncomingDocument:version','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d0e655d4-83f5-8d40-c545-11b01a8da441','0','30','daex$IncomingDocument:deleteTs','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b36252f1-6e77-5803-c241-60c3e6994656','0','30','daex$IncomingDocument:updatedBy','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d3ec9066-551e-dc50-0460-7ca8853c3cc6','0','30','daex$IncomingDocument:description','2','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('8a4e20bb-3eec-cba4-e5f4-4d6637c94878','0','30','daex$IncomingDocument:files','2','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('d5f7e708-6564-c8e9-3d6a-ceea0451270b','0','30','daex$IncomingDocument:id','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('10c1c2ae-bd70-7590-7c5d-17b4b75a2861','0','30','daex$IncomingDocument:createdBy','0','4c82f733-9d20-b11d-0078-f8e68638948f');

INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('3782a22a-ad19-3ed9-eb4d-6d2f0d4badea','0','30','daex$RemarkAnswer:answer','2','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('b9b31ba1-8a9d-53ef-3251-d182a18f9a7a','0','30','daex$RemarkAnswer:remark','1','4c82f733-9d20-b11d-0078-f8e68638948f');


-- Настройка Специфичные
--INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
--    VALUES ('f2816689-c782-19c1-939c-236ff87e965d','0','40','cuba.gui.filter.global','0','4c82f733-9d20-b11d-0078-f8e68638948f');
--INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
--    VALUES ('f5a14531-2966-f988-dba6-580d456e3252','0','40','cuba.gui.filter.maxResults','0','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c607823f-7355-4ab2-d955-77396b08ee8f','0','40','cuba.gui.filter.edit','1','4c82f733-9d20-b11d-0078-f8e68638948f');
--INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
--    VALUES ('dce19dfd-a0c1-1773-48fa-76bed24220b8','0','40','cuba.gui.filter.customConditions','0','4c82f733-9d20-b11d-0078-f8e68638948f');

-- Настройки Интерфейс
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('1bfe4b65-c469-a196-a1fa-c61901b7e381','0','50','daex$RemarkAnswer.edit:buttonUnload','2','4c82f733-9d20-b11d-0078-f8e68638948f');


INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('c964d46b-f88f-d051-f7ef-a1e37b4a853d','0','50','daex$ExpertiseCustomer.browse:buttonReport_2','2','4c82f733-9d20-b11d-0078-f8e68638948f');
INSERT INTO sec_permission(id, version, permission_type, target, value_, role_id)
    VALUES ('500f05d4-6a29-2e11-3ee2-4700f47a4c3d','0','50','daex$ExpertiseCustomer.browse:buttonReport_1','2','4c82f733-9d20-b11d-0078-f8e68638948f'); 

-- end Customer

-- end Permission

-- begin Group

-- Создание группы GIP
INSERT INTO sec_group(id, version,  name, parent_id)
    VALUES ('575818da-d126-35bb-1b27-ac4b0a340be7','0','GIP','0fa2b1a5-1d68-4d69-9fbd-dff348347f93');

-- Создание группы Expert
INSERT INTO sec_group(id, version, name, parent_id)
    VALUES ('9a7c1414-3f97-241a-0df1-2f5b93f60354','0','Expert','0fa2b1a5-1d68-4d69-9fbd-dff348347f93');

-- Создание группы Customer
INSERT INTO sec_group(id, version,  name, parent_id)
    VALUES ('342277a3-7688-93d0-be0a-26f490cdcb18','0','Customer', '0fa2b1a5-1d68-4d69-9fbd-dff348347f93');
-- end Group

-- begin Constraint
-- Создание ограничений на доступ к БД для чтения
--GIP
INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('cfc9b304-f30b-c23d-2237-b9dff7521775','0','','db','read','daex$Expertise','','{E}.leaderEmployee.user_sys.id = :session$userId','','','t','575818da-d126-35bb-1b27-ac4b0a340be7');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('d4aae327-eacb-ad0c-ffe1-a5f570b03d65','0','','db','read','daex$RPD','JOIN daex$Expertise ex ON ex.id = {E}.expertiseRPD.id','ex.leaderEmployee.user_sys.id = :session$userId','','','t','575818da-d126-35bb-1b27-ac4b0a340be7');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('49bdb83e-cfcf-509d-fff8-bd677ce2e13a','0','','db','read','daex$RPDFile','JOIN daex$RPD rpd ON rpd.id = {E}.rpd.id
JOIN daex$Expertise ex ON ex.id = rpd.expertiseRPD.id','ex.leaderEmployee.user_sys.id = :session$userId','','','t','575818da-d126-35bb-1b27-ac4b0a340be7');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('49a39992-a13f-0073-cba0-bf843660ea25','0','','db','read','daex$RemarkAnswer','JOIN daex$RPDFile rpdf ON rpdf.id = {E}.rpdFile.id
JOIN daex$RPD rpd ON rpd.id = rpdf.rpd.id
JOIN daex$Expertise ex ON ex.id = rpd.expertiseRPD.id','ex.leaderEmployee.user_sys.id = :session$userId','','','t','575818da-d126-35bb-1b27-ac4b0a340be7');


--Expert
INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('7f584e16-49fe-7151-9f13-9728190cc475','0','','db','read','daex$Expertise','JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = {E}.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','9a7c1414-3f97-241a-0df1-2f5b93f60354');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('031afd0d-e850-dc5d-0d44-863c8ce404f1','0','','db','read','daex$RPD','JOIN daex$Expertise ex ON ex.id = {E}.expertiseRPD.id
JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = ex.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','9a7c1414-3f97-241a-0df1-2f5b93f60354');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('3384e0f1-9704-2bb4-5b2b-c12c04bde851','0','','db','read','daex$RPDFile','JOIN daex$Expertise ex ON ex.id = rpd.expertiseRPD.id
JOIN daex$RPD rpd ON rpd.id = {E}.rpd.id
JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = ex.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','9a7c1414-3f97-241a-0df1-2f5b93f60354');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('0678444c-61a3-7a92-fc7e-f05047d82eff','0','','db','read','daex$RemarkAnswer','JOIN daex$Expertise ex ON ex.id = rpd.expertiseRPD.id
JOIN daex$RPD rpd ON rpd.id = rpdf.rpd.id
JOIN daex$RPDFile rpdf ON rpdf.id = {E}.rpdFile.id
JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = ex.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','9a7c1414-3f97-241a-0df1-2f5b93f60354');


--Customer
INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('8ec152d5-6ebc-20bc-ab2c-2c6ffdbfecb2','0','','db','read','daex$Expertise','JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = {E}.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','342277a3-7688-93d0-be0a-26f490cdcb18');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('bd82ad37-5b85-c47b-6e05-075515f3fc5b','0','','db','read','daex$RPD','JOIN daex$Expertise ex ON ex.id = {E}.expertiseRPD.id
JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = ex.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','342277a3-7688-93d0-be0a-26f490cdcb18');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('c92e8072-d5c5-8611-a4d1-2d2d2bd14eb6','0','','db','read','daex$RPDFile','JOIN daex$Expertise ex ON ex.id = rpd.expertiseRPD.id
JOIN daex$RPD rpd ON rpd.id = {E}.rpd.id
JOIN daex$AccessSettings acs ON acs.expertiseAccessSettings.id = ex.id','acs.isRead = true
AND acs.user.id = :session$userId','','','t','342277a3-7688-93d0-be0a-26f490cdcb18');

INSERT INTO sec_constraint(id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('8559e698-9200-8db3-7cfb-70b6e563e031','0','','db','read','daex$RemarkAnswer','JOIN daex$RPDFile f ON {E}.rpdFile.id = f.id
JOIN daex$RPD p ON f.rpd.id = p.id
JOIN daex$Expertise ex ON p.expertiseRPD.id = ex.id
JOIN daex$AccessSettings a ON a.expertiseAccessSettings.id = ex.id','a.isRead = true
AND a.user.id = :session$userId 
AND {E}.isFixed = false','','','t','342277a3-7688-93d0-be0a-26f490cdcb18');

INSERT INTO sec_constraint( id, version, code, check_type, operation_type, entity_name, join_clause, where_clause, groovy_script, filter_xml, is_active, group_id)
    VALUES ('db10a934-4ea1-d47f-2a33-446651b6a4d5','0','','db','read','daex$IncomingDocument','','{E}.createdBy = :session$userLogin','','','t','342277a3-7688-93d0-be0a-26f490cdcb18');
-- end Constraint


-- begin 
-- Создание записей в справочнике Head_RPD
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('62a9eb31-b4bb-3e75-b2d0-c34ab965a065','0','ПЗ','Пояснительная записка');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('ebd07c99-57b3-237d-19c4-398dc092761a','0','ПЗУ','Схема планировочной организации земельного участка');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('45011a7e-54e9-bad4-0dd0-42587a179a31','0','АР','Архитектурные решения');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('ccf27d70-ed0d-ce82-32e4-8ba758fac45f','0','КР','Конструктивные и объемно-планировочные решения');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('959f8cf1-f15e-79dd-e3e9-2868fefbf16b','0','ПОС','Проект организации строительства');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('0ae7ea92-ba6f-8f7b-3263-5e8c92966c18','0','ООС','Перечень мероприятий по охране окружающей среды');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('37825e55-dd55-8fd7-362a-cd18fe9b565f','0','ПБ','Мероприятия по обеспечению пожарной безопасности');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('68c0b33a-672e-99ae-b688-6e402dce376a','0','ОДИ','Мероприятия по обеспечению доступа инвалидов');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('255c5e72-af46-fe12-2180-0cae3cf3b67e','0','ТБЭ','Требования к обеспечению безопасной эксплуатации объекта капитального строительства');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('785d1611-acf2-1551-3c04-4661b726eb61','0','ГОЧС',
            'Перечень мероприятий по ГО, мероприятий по предупреждению ЧС природного и техногенного характера, мероприятий по противодействию терроризму');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('50290f5a-cb67-0cfe-108e-bf04135cd375','0','ДПБ','Декларация промышленной безопасности опасных производственныйх объектов');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('2bda7c6a-da4b-0788-f973-5a7b3cbac4cd','0','ДБГ','Декларация безопасности гидротехнических сооружений');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('de8c68a5-0adb-6972-95a8-61e3748b6004','0','ППО','Проект полосы отвода');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('c25f0367-2168-d98a-51f6-94999bc1d869','0','ТКР','Технологические и конструктивные решения линейного объекта. Искусственные сооружения');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('28ef46f2-826e-8ecc-102d-9966b77fae63','0','ИЛО','Здания, строения и сооружения, входящие в инфраструктуру линейного обьекта');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('c5ccf885-e7c5-9f90-c14c-ed888511a55d','0','ПОД','Проект организации работ по сносу(демонтажу) обьектов капитального(линейного) строительства');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('51c43d47-28ef-40c0-af78-2405e1d1d4ba','0','СМ','Смета на строительство');

INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('940d2f09-ad6f-8ba0-5676-2c4625834b58','0','ЭЭ',
            'Мероприятия по обеспечению соблюдения требований энергетической эффективности и требований оснащенности зданий, 
            строений и сооружений приборами учета используемых энергетических ресурсов');
    
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('5dbe907a-c342-c2ca-daa3-573ea717def8','0','ИОС',
            'Сведения об инженерном оборудовании, о сетях инженерно-технического обеспечения, перечень инженерно-технических мероприятий, 
            содержание технологических решений');
            
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('9ac7c3e1-f350-480d-bd57-f426a1c7c3c0','0','ИОС1',
            'Подраздел: Система электроснабжения');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('ec42d437-5581-41b9-9b24-418a612b292a','0','ИОС1-ЭГ',
            'Молниезащита и заземление');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('b1f9bcaa-4743-4437-b64c-1ff7cc925bf5','0','ИОС1-ЭС',
            'Электроснабжение (от ТП до ВРУ)');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('547662b7-3599-4631-b84e-db185d156c0e','0','ИОС1-ЭМ',
            'Электрооборудование (компьютеры, холодильники, электрические розетки, насосы, двигатели и т.п.)');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('2ac9ab63-2613-4b3a-accf-103704eed307','0','ИОС1-ЭО',
            'Электроосвещение внутреннее');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('c304aa84-3e73-48ae-81b1-c835c3d8992c','0','ИОС1-ЭН',
            'Электроосвещение наружное');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('ee9bf17c-f88c-40a5-a7bb-9c2fdb41c8e1','0','ИОС2',
            'Подраздел: Система водоснабжения');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('968512a3-e866-4ad6-912f-1eb311f0acaf','0','ИОС3',
            'Подраздел: Система водоотведения');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('2e905352-9692-41d3-bfca-d6b7f9f12f6d','0','ИОС4',
            'Подраздел: Отопление, вентиляция и кондиционирование воздуха, тепловые сети');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('f1de1097-b785-4589-928d-812e40323491','0','ИОС5',
            'Подраздел: Сети связи');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('53b39578-0d92-486a-b5e5-ed8fb21dfac1','0','ИОС6',
            'Подраздел: Система газоснабжения');
INSERT INTO daex_head_rpd(id,version,pressmark,name)
    VALUES ('e667da82-d3ca-4c25-b7e3-099397f3dec6','0','ИОС7',
            'Подраздел: Технологические решения');

-- end
