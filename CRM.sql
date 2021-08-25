/* Создание Базы CRM для аутсорсинговой компании в сфере IT. 
 * 
 * База содержит данные Заказчика и Исполнителя (ведёт базу).
 * Данные заполняются для упорядочения работы с кандидатами на вакансии Заказчика.
 * Заказчик сообщает исполнителю сколько сотрудников и на какие вакансии ему необходимы.
 * Исполнитель, используя ресурсы подбирает Заказчику потенциальных кандидатов на открытые вакансии.
 */

USE crm;


/*
 * TABLE STRUCTURE FOR: implementer
 * Создаём таблицу с информацией по Исполнителю (компания которая находит кандидатов для Заказчика).
 * Компания может входить в группу компаний и иметь несколько компаний-исполнителей.
*/

DROP TABLE IF EXISTS implementer;

CREATE TABLE implementer (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  company_name varchar(70) NOT NULL COMMENT 'НАИМЕНОВАНИЕ КОМПАНИИ',
  inn char(10) NOT NULL COMMENT 'ИНН КОМПАНИИ',
  kpp char(9) NOT NULL COMMENT 'КПП КОМПАНИИ',
  address varchar(200) NOT NULL COMMENT 'ЮРИДИЧЕСКИЙ АДРЕС КОМПАНИИ',
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY inn (inn),
  UNIQUE KEY kpp (kpp)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: position_employee
* Создаём таблицу внутренних должностей ответственных компаний Заказчика и Исполнителя.
*/

DROP TABLE IF EXISTS position_employee;

CREATE TABLE position_employee (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB;

-- Добавляем возможные позиции по внутренним вакансиям ответственных:
INSERT INTO position_employee VALUES (DEFAULT, 'Рекрутер'),
(DEFAULT, 'Старший рекрутер'),
(DEFAULT, 'Ресурсный менеджер'),
(DEFAULT, 'Младший менеджер'),
(DEFAULT, 'Старший менеджер'),
(DEFAULT, 'Менеджер'),
(DEFAULT, 'Руководитель направления'),
(DEFAULT, 'Руководитель разработки'),
(DEFAULT, 'Менджер проекта'),
(DEFAULT, 'Директор');


/*
 * TABLE STRUCTURE FOR: implementer_employee
 * Создаём таблицу с информацией по сотрудникам Исполнителя.
 * Информация необходима для обозначения ответственного со стороны исполнителя.
 * Ответственным со стороны Исполнителя является сотрудник, который нашёл кандидата на каком-либо ресурсе
 * и ведёт его до получения решения по кандидату. 	
*/

DROP TABLE IF EXISTS implementer_employee;

CREATE TABLE implementer_employee (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  implementer_id bigint unsigned NOT NULL,
  surname varchar(50) NOT NULL COMMENT 'ФАМИЛИЯ',
  name varchar(50) NOT NULL,
  middle_name varchar(50) NOT NULL COMMENT 'ОТЧЕСТВО',
  position_employee_id bigint unsigned NOT NULL COMMENT 'ДОЛЖНОСТЬ СОТРУДНИКА ИСПОЛНИТЕЛЯ',
  telephone char(11) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY telephone (telephone),
  CONSTRAINT fk_implementer FOREIGN KEY (implementer_id) REFERENCES implementer(id),
  CONSTRAINT fk_position_employee FOREIGN KEY (position_employee_id) REFERENCES position_employee(id)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: client
* Создаём таблицу с информацией по Заказчику (Клиенту).
*/

DROP TABLE IF EXISTS client;

CREATE TABLE client (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  company_name varchar(50) NOT NULL COMMENT 'НАИМЕНОВАНИЕ КОМПАНИИ',
  inn char(11) NOT NULL COMMENT 'ИНН КОМПАНИИ',
  kpp char(11) NOT NULL COMMENT 'КПП КОМПАНИИ',
  address varchar(200) NOT NULL COMMENT 'ЮРИДИЧЕСКИЙ АДРЕС КОМПАНИИ',
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY inn (inn),
  UNIQUE KEY kpp (kpp),
  KEY client_company_name_idx (company_name)
) ENGINE=InnoDB;

 
/*
 * TABLE STRUCTURE FOR: client_employee
 * Создаём таблицу с информацией сотрудников Заказчика.
 * Информация необходима для обозначения ответственного за проекты на которые требуются кандидаты.
 * Ответственному направляется вся информация по кандидату на согласование.	
*/

DROP TABLE IF EXISTS client_employee;

CREATE TABLE client_employee (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  client_id bigint unsigned NOT NULL,
  surname varchar(50) NOT NULL COMMENT 'ФАМИЛИЯ',
  name varchar(50) NOT NULL,
  middle_name varchar(50) NOT NULL COMMENT 'ОТЧЕСТВО',
  position_employee_id bigint unsigned NOT NULL COMMENT 'ДОЛЖНОСТЬ СОТРУДНИКА ЗАКАЗЧИКА',
  telephone char(11) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY telephone (telephone),
  CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client(id),
  CONSTRAINT fk_position_employee_1 FOREIGN KEY (position_employee_id) REFERENCES position_employee(id)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: closing_vacancy
* Создаём таблицу для причин по которым могут быть закрыты вакансии.
*/

 DROP TABLE IF EXISTS closing_vacancy;

CREATE TABLE closing_vacancy (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB;

-- Добавляем возможные причины по которым могут быть закрыты вакансии:
INSERT INTO closing_vacancy VALUES
(DEFAULT, 'Найден сотрудник компанией Заказчика'),
(DEFAULT, 'Истёк дедлайн'),
(DEFAULT, 'Вакансия закрыта другим вендором'),
(DEFAULT, 'Не актуально');


/*
* TABLE STRUCTURE FOR: grade
* Создаём таблицу с грейдом по вакансиям.
*/

DROP TABLE IF EXISTS grade;

CREATE TABLE grade (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB;

-- Добавляем возможный грейд по вакансиям (по некоторым вакансиям грейд отсутствует):
INSERT INTO grade VALUES (DEFAULT, 'Отсутствует по типу вакансии'),
(DEFAULT, 'Junior'),
(DEFAULT, 'Middle'),
(DEFAULT, 'Senor');


/*
* TABLE STRUCTURE FOR: vacancies_type
* Создаём таблицу должностей Заказчика, на которые могут быть приглашены кандидаты.
*/

DROP TABLE IF EXISTS vacancies_type;

CREATE TABLE vacancies_type (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name),
  KEY vacancies_type_name_idx (name)
) ENGINE=InnoDB;

-- Добавляем возможные позиции по вакансии:
INSERT INTO vacancies_type VALUES (DEFAULT, 'Tester'),
(DEFAULT, 'Analyst'),
(DEFAULT, 'Front-end_developer'),
(DEFAULT, 'Back-end_developer'),
(DEFAULT, 'Android_developer'),
(DEFAULT, 'iOS_developer'),
(DEFAULT, 'Product_designer'),
(DEFAULT, 'Web_designer'),
(DEFAULT, 'UX_designer'),
(DEFAULT, 'Product_manager'),
(DEFAULT, 'The_head_of_the_department'),
(DEFAULT, 'System_administrator');


/*
* TABLE STRUCTURE FOR: priority_vacancy
* Создаём таблицу с приоритетом по вакансиям Заказчика. 
* Коэффицент может добавляться к дате днями, чтобы выявить дату дедлайна.
*/

DROP TABLE IF EXISTS priority_vacancy;

CREATE TABLE priority_vacancy (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  term varchar(200) NOT NULL,
  coefficient char(11) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name)
) ENGINE=InnoDB;

-- Добавляем приоритет по вакансиям:
INSERT INTO priority_vacancy VALUES 
(DEFAULT, '1-й приоритет', '1 неделя на поиск', 7),
(DEFAULT, '2-й приоритет', '2 недели на поиск', 14),
(DEFAULT, '3-й приоритет', '4 недели на поиск', 28),
(DEFAULT, '4-й приоритет', '8 недель на поиск', 56);


/*
* TABLE STRUCTURE FOR: projects
* Создаём таблицу с информацией по проектам Заказчика и ответственными по ним.
*/

DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  project varchar(50) NOT NULL COMMENT 'НАИМЕНОВАНИЕ ПРОЕКТА',
  client_id bigint unsigned NOT NULL,
  client_employee_id bigint unsigned NOT NULL,
  implementer_employee_id bigint unsigned NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  KEY projects_project_idx (project),
  CONSTRAINT fk_client_1 FOREIGN KEY (client_id) REFERENCES client(id),
  CONSTRAINT fk_client_employee_1 FOREIGN KEY (client_employee_id) REFERENCES client_employee(id),
  CONSTRAINT fk_implementer_employee FOREIGN KEY (implementer_employee_id) REFERENCES implementer_employee(id)
) ENGINE=InnoDB;


/*
 * TABLE STRUCTURE FOR: vacancies
 * Создаём таблицу с информацией по вакансиям от Заказчика.
 * Информация необходима для отслеживания вакансий, на которые необходим подбор кандидатов.	
*/

DROP TABLE IF EXISTS vacancies;

CREATE TABLE vacancies (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  implementer_id bigint unsigned NOT NULL COMMENT 'КОМПАНИЯ ИСПОЛНИТЕЛЬ',
  client_id bigint unsigned NOT NULL COMMENT 'КОМПАНИЯ ЗАКАЗЧИК',
  vacancies_type_id bigint unsigned NOT NULL COMMENT 'ВАКАНСИЯ',
  projects_id bigint unsigned NOT NULL,
  grade_id bigint unsigned COMMENT 'ГРЕЙД ПО ВАКАНСИИ',
  job_opening_date date COMMENT 'ДАТА РАЗМЕЩЕНИЯ ВАКАНСИИ',
  priority_vacancy_id bigint unsigned NOT NULL,
  deadline date COMMENT 'DEADLINE ПО ЗАКРЫТИЮ ВАКАНСИИ',
  job_closing_date date COMMENT 'ДАТА ЗАКРЫТИЯ ВАКАНСИИ',
  closing_vacancy_id bigint unsigned NOT NULL COMMENT 'ПРИЧИНА ЗАКРЫТИЯ ВАКАНСИИ',
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  CONSTRAINT fk_implementer_vacancies FOREIGN KEY (implementer_id) REFERENCES implementer(id),
  CONSTRAINT fk_client_vacancies FOREIGN KEY (client_id) REFERENCES client(id),
  CONSTRAINT fk_vacancies_type_vacancies FOREIGN KEY (vacancies_type_id) REFERENCES vacancies_type(id),
  CONSTRAINT fk_projects_vacancies FOREIGN KEY (projects_id) REFERENCES projects(id),
  CONSTRAINT fk_grade_vacancies FOREIGN KEY (grade_id) REFERENCES grade(id),
  CONSTRAINT fk_priority_vacancy_vacancies FOREIGN KEY (priority_vacancy_id) REFERENCES priority_vacancy(id),
  CONSTRAINT fk_closing_vacancy_vacancies FOREIGN KEY (closing_vacancy_id) REFERENCES closing_vacancy(id)
) ENGINE=InnoDB;

 
/*
* TABLE STRUCTURE FOR: candidate
* Создаём таблицу кандидатов.
*/

DROP TABLE IF EXISTS candidate;

CREATE TABLE candidate (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  surname varchar(50) NOT NULL COMMENT 'ФАМИЛИЯ',
  name varchar(50) NOT NULL,
  middle_name varchar(50) NOT NULL COMMENT 'ОТЧЕСТВО',
  telephone char(11) NOT NULL,
  email varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY email (email),
  UNIQUE KEY telephone (email),
  KEY candidate_email_idx (email),
  KEY candidate_telephone_idx (telephone)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: candidate_data
* Добавляем таблицу с более подробными данными по кандидатам.
*/

DROP TABLE IF EXISTS candidate_data;

CREATE TABLE candidate_data (
  candidate_id bigint unsigned NOT NULL,
  date_of_birth date NOT NULL,
  gender enum('м','ж') NOT NULL,
  current_city varchar(130) NOT NULL,
  ready_to_move enum('да','нет') NOT NULL,
  family_status enum(' Холост/Не замужем',' Женат/Замужем') NOT NULL,
  schedule enum('5/2','2/2') NOT NULL COMMENT 'ГРАФИК РАБОТЫ',
  PRIMARY KEY (candidate_id),
  CONSTRAINT fk_candidate_candidate_data FOREIGN KEY (candidate_id) REFERENCES candidate(id)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: position_of_candidates
* Создаём таблицу по текущей должности кандидата, занимаемой в настоящее время.
*/

DROP TABLE IF EXISTS position_of_candidates;

CREATE TABLE position_of_candidates (
  candidate_id bigint unsigned NOT NULL,
  vacancies_type_id bigint unsigned NOT NULL COMMENT 'ДОЛЖНОСТЬ',
  work_experience char(2) NOT NULL COMMENT 'СТАЖ РАБОТЫ',
  job_experience char(2) NOT NULL COMMENT 'СТАЖ ПО ДОЛЖНОСТИ',
  waiting_for_salary char(10) NOT NULL COMMENT 'ОЖИДАНИЯ ПО ЗАРАБОТНОЙ ПЛАТЕ',
  currency enum('RUB','USD', 'EUR') NOT NULL COMMENT 'ВАЛЮТА ЗАРАБОТНОЙ ПЛАТЫ',
  PRIMARY KEY (candidate_id),
  CONSTRAINT fk_candidate_position_of_candidates FOREIGN KEY (candidate_id) REFERENCES candidate(id),
  CONSTRAINT fk_vacancies_type_position_of_candidates FOREIGN KEY (vacancies_type_id) REFERENCES vacancies_type(id)
) ENGINE=InnoDB;


/*
* TABLE STRUCTURE FOR: interview_status
* Создаём таблицу с вариантами статуса по собеседуемым кандидатам.
*/

DROP TABLE IF EXISTS interview_status;

CREATE TABLE interview_status (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name),
  KEY interview_status_name_idx (name)
) ENGINE=InnoDB;

-- Добавляем возможные статусы по завершению любого этапа собеседования:
INSERT INTO interview_status VALUES (DEFAULT, 'Новый'),
(DEFAULT, 'Сообщение с описанием вакансии отправлено'),
(DEFAULT, 'Созвон'),
(DEFAULT, 'Техническое собеседование'),
(DEFAULT, 'Собеседование с Заказчиком'),
(DEFAULT, 'Прохождение службы безопасности у Заказчика'),
(DEFAULT, 'Оффер'),
(DEFAULT, 'Трудоустроен');


/*
* TABLE STRUCTURE FOR: decision
* Таблица содержит решение по кандидату как от Заказчика и от Исполнителя, так и от самого кандидата.
*/

DROP TABLE IF EXISTS decision;

CREATE TABLE decision (
  id bigint unsigned NOT NULL AUTO_INCREMENT,
  name varchar(200) NOT NULL COMMENT 'РЕШЕНИЕ ПО СОТРУДНИКУ',
  PRIMARY KEY (id),
  UNIQUE KEY id (id),
  UNIQUE KEY name (name),
  KEY decision_name_idx (name)
) ENGINE=InnoDB;

-- Добавляем возможные решения по кандидату:
INSERT INTO decision VALUES 
(DEFAULT, 'Кандидат не подходит нашей компании'),
(DEFAULT, 'Отказ кандидата'),
(DEFAULT, 'Отказ Заказчика');


/*
* TABLE STRUCTURE FOR: сandidate_status
* Таблица с решениями по кандидатам.
*/

DROP TABLE IF EXISTS сandidate_status;

CREATE TABLE сandidate_status (
  candidate_id bigint unsigned NOT NULL,
  vacancies_type_id bigint unsigned NOT NULL COMMENT 'ДОЛЖНОСТЬ НА КОТОРУЮ СОБЕСЕДУЕТСЯ КАНДИДАТ',
  date_beginning date COMMENT 'ДАТА НАЧАЛА ВЗАИМОДЕЙСТВИЯ С КАНДИДАТОМ',
  interview_status_id bigint unsigned NOT NULL COMMENT 'СТАТУС СОБЕСЕДОВАНИЯ/РАБОТЫ ПО СОТРУДНИКУ',
  stage_date date COMMENT 'ДАТА ПРОХОЖДЕНИЯ ЭТАПА',
  decision_id bigint unsigned NOT NULL COMMENT 'РЕШЕНИЕ ПО СОТРУДНИКУ',
  decision_date date COMMENT 'ДАТА ВЫНЕСЕНИЯ РЕШЕНИЯ',
  PRIMARY KEY (candidate_id),
  CONSTRAINT fk_candidate_id FOREIGN KEY (candidate_id) REFERENCES candidate(id),
  CONSTRAINT fk_vacancies_type_сandidate_status FOREIGN KEY (vacancies_type_id) REFERENCES vacancies_type(id),
  CONSTRAINT fk_interview_status_сandidate_status FOREIGN KEY (interview_status_id) REFERENCES interview_status(id),
  CONSTRAINT fk_decision_сandidate_status FOREIGN KEY (decision_id) REFERENCES decision(id)
) ENGINE=InnoDB;

-- Генерируем данные для таблицы implementer
INSERT INTO implementer (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Olson, Witting and Greenfelder', '1417353528', '512770716', '7218 Kaci Street\nAlberthaburgh, DE 22062-0611');
INSERT INTO implementer (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Russel-Johns', '8729202613', '935344211', '786 Nichole Alley\nDarlenechester, IL 84506-6633');
INSERT INTO implementer (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Robel, Rippin and Lakin', '4697371032', '619100169', '3303 Keshawn Walk\nPort Rosalyn, MA 44964');

-- Генерируем данные для таблицы implementer_employee
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '1', 'O\'Reilly', 'Abagail', 'Arnoldo', '4', '93290466758', 'mireya.bradtke@example.net');
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '2', 'Gislason', 'Tamia', 'Levi', '3', '29240534370', 'johann81@example.com');
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '3', 'Keeling', 'Retta', 'Owen', '4', '75155342443', 'orn.karl@example.org');
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '1', 'Carroll', 'Audra', 'Arthur', '7', '30233559414', 'boehm.elliott@example.net');
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '2', 'Smitham', 'Macie', 'Lonny', '9', '94191428132', 'dbartoletti@example.net');
INSERT INTO implementer_employee (id, implementer_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '3', 'Fahey', 'Laurianne', 'Durward', '3', '80976500585', 'kiehn.hardy@example.net');

-- Генерируем данные для таблицы client
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Bruen Group', '52947483089', '20639196202', '1185 Williamson Keys Suite 839\nNew Adolf, FL 14766');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Heller-Mertz', '28836189402', '08274127914', '96668 Sally Square\nLake Constantinton, OR 51361');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Powlowski-Wisoky', '26460837445', '49036308350', '7906 Hermann Stravenue Suite 482\nNew Kelley, MA 53695');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Littel-Lesch', '86282620541', '71560499310', '4767 Powlowski Fords Apt. 539\nAdanfurt, DE 39336-6770');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Medhurst Group', '99736780376', '96373386574', '5060 Athena Course\nDoraland, SD 32470-4087');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Kassulke Group', '63581525575', '29859718717', '0017 Connor Stravenue Suite 548\nTillmanmouth, SC 51795-1572');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Johnson, Mayert and Buckridge', '72711427039', '50056685178', '09179 Farrell Key Suite 781\nMonroemouth, DE 56514');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Robel, O\'Keefe and Grady', '32028199688', '59855367678', '589 Myriam Station\nKingchester, AK 65875-4606');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Yost, Treutel and Glover', '82318070153', '64424940398', '4704 Tod Hollow Apt. 090\nNorth Alexannehaven, AK 50502');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Price, Wilderman and Graham', '88183366248', '65784037082', '3069 Johnson Stravenue Suite 218\nGaylordbury, NV 54321-7521');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Dooley-Davis', '23352327691', '11569018579', '4119 Bonnie Mall Apt. 003\nNorth Jaquelin, SD 66898');
INSERT INTO client (id, company_name, inn, kpp, address) VALUES (DEFAULT, 'Hilpert, Turner and Howell', '09467823559', '36153306744', '75322 Hoeger Burg Apt. 203\nFeilside, WV 61982-3009');

-- Генерируем данные для таблицы client_employee
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '1', 'Hodkiewicz', 'Marie', 'Weston', '5', '20066374762', 'hzboncak@example.net');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '2', 'Gusikowski', 'Bridie', 'Alexie', '10', '37701115513', 'rfadel@example.net');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '3', 'Volkman', 'Jaqueline', 'Trevion', '6', '70976798635', 'kemmer.jadon@example.com');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '4', 'Reinger', 'Annette', 'Keaton', '3', '72351329546', 'roma.marvin@example.com');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '5', 'Gutkowski', 'Prudence', 'Kade', '9', '75313037467', 'khomenick@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '6', 'Green', 'Ethelyn', 'Arjun', '2', '29843790043', 'o\'connell.angie@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '7', 'Tremblay', 'Cydney', 'Sigrid', '2', '18691013766', 'nigel32@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '8', 'Bradtke', 'Jacklyn', 'Ward', '1', '99503662950', 'stehr.isai@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '9', 'Torp', 'Dahlia', 'Afton', '9', '87184673301', 'bennie.gaylord@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '10', 'Huels', 'Eva', 'Arden', '7', '67371552463', 'kristofer11@example.com');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '11', 'Gutmann', 'Lola', 'Percy', '8', '21521238928', 'mkrajcik@example.net');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '12', 'Runolfsdottir', 'Eleanora', 'Anibal', '7', '09981158515', 'bednar.reina@example.com');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '1', 'Lemke', 'Chasity', 'Hoyt', '9', '94878748760', 'waters.sasha@example.org');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '2', 'Brekke', 'Anya', 'Broderick', '6', '34059701806', 'lauriane.o\'keefe@example.com');
INSERT INTO client_employee (id, client_id, surname, name, middle_name, position_employee_id, telephone, email) VALUES (DEFAULT, '3', 'Jaskolski', 'Caitlyn', 'Jovanny', '9', '87173673431', 'cathy.sipes@example.com');

-- Генерируем данные для таблицы projects
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('1', 'Focused uniform framework', '1', '5', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('2', 'Multi-channelled background orchestration', '2', '4', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('3', 'Versatile scalable attitude', '3', '4', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('4', 'Persistent analyzing focusgroup', '4', '1', '2');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('5', 'Innovative multimedia methodology', '5', '11', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('6', 'Optional hybrid extranet', '6', '3', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('7', 'Object-based secondary interface', '7', '15', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('8', 'Re-contextualized heuristic standardization', '8', '15', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('9', 'Upgradable radical flexibility', '9', '10', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('10', 'Advanced real-time portal', '10', '5', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('11', 'Versatile zerodefect project', '11', '8', '5');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('12', 'Synergistic stable frame', '12', '15', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('13', 'Innovative didactic software', '1', '10', '5');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('14', 'Team-oriented 6thgeneration productivity', '2', '10', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('15', 'Seamless zerotolerance methodology', '3', '8', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('16', 'Devolved needs-based access', '4', '5', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('17', 'Future-proofed local strategy', '5', '6', '4');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('18', 'Balanced user-facing GraphicalUserInterface', '6', '11', '4');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('19', 'Operative transitional array', '7', '15', '5');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('20', 'Front-line solution-oriented orchestration', '8', '15', '4');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('21', 'Adaptive 24/7 throughput', '9', '4', '1');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('22', 'Facetoface multimedia policy', '10', '9', '2');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('23', 'Enterprise-wide zerotolerance structure', '11', '8', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('24', 'Inverse fresh-thinking matrices', '12', '10', '1');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('25', 'Cloned nextgeneration encryption', '1', '6', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('26', 'Multi-layered actuating leverage', '2', '10', '6');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('27', 'Public-key upward-trending attitude', '3', '11', '4');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('28', 'Expanded composite frame', '4', '13', '2');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('29', 'Upgradable leadingedge monitoring', '5', '4', '3');
INSERT INTO projects (id, project, client_id, client_employee_id, implementer_employee_id) VALUES ('30', 'Triple-buffered bi-directional protocol', '6', '4', '5');

-- Генерируем данные для таблицы vacancies
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('1', '1', '1', '2', '3', '4', '2021-01-06', '2', '2021-01-06', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('2', '2', '12', '12', '2', '2', '2007-04-20', '4', '2007-04-14', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('3', '3', '4', '2', '2', '1', '2007-04-14', '4', '2007-10-17', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('4', '3', '10', '5', '14', '4', '2007-07-10', '3', '2007-07-16', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('5', '3', '12', '10', '29', '1', '2007-07-21', '4', '1978-04-26', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('6', '3', '4', '9', '13', '2', '2016-01-25', '3', '2011-05-22', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('7', '3', '7', '7', '21', '4', '1980-11-24', '3', '2014-09-20', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('8', '3', '6', '5', '22', '2', '2011-01-13', '3', '2016-02-14', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('9', '1', '4', '12', '26', '2', '1976-10-29', '4', '1986-01-24', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('10', '1', '9', '11', '3', '1', '2015-05-20', '3', '2013-02-09', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('11', '1', '3', '12', '30', '3', '1987-01-30', '3', '2006-08-18', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('12', '2', '3', '5', '10', '3', '2016-11-19', '4', '2001-11-20', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('13', '3', '7', '3', '1', '4', '1976-11-08', '1', '2007-09-06', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('14', '1', '12', '8', '10', '3', '1993-11-02', '3', '2015-01-23', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('15', '3', '1', '11', '29', '2', '1996-12-21', '4', '2007-12-24', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('16', '3', '6', '8', '14', '3', '1985-04-22', '4', '1970-12-23', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('17', '1', '10', '10', '8', '2', '1991-12-23', '1', '1975-09-17', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('18', '1', '3', '2', '6', '1', '1998-07-08', '4', '2007-05-23', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('19', '3', '4', '12', '17', '2', '1978-08-18', '4', '2019-11-06', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('20', '2', '9', '5', '17', '1', '1982-08-27', '4', '2004-05-15', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('21', '3', '12', '10', '3', '4', '2008-04-12', '3', '1993-10-03', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('22', '1', '8', '8', '6', '4', '1987-12-13', '3', '1999-03-20', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('23', '1', '6', '11', '1', '4', '2000-07-16', '4', '2012-02-14', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('24', '1', '8', '1', '21', '2', '1999-01-10', '2', '1991-09-23', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('25', '2', '6', '4', '10', '2', '2009-12-07', '1', '2011-04-22', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('26', '1', '9', '9', '10', '2', '1995-05-19', '2', '1981-08-03', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('27', '1', '12', '11', '12', '2', '2007-05-21', '3', '1977-04-03', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('28', '1', '7', '12', '11', '1', '1970-12-26', '1', '2011-06-28', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('29', '2', '6', '4', '3', '4', '1971-09-24', '3', '2002-10-01', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('30', '2', '8', '10', '20', '2', '2002-11-08', '2', '2011-08-03', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('31', '2', '10', '6', '27', '4', '2013-03-08', '2', '1995-11-30', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('32', '1', '2', '8', '16', '3', '1970-10-06', '3', '1994-01-31', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('33', '3', '7', '12', '12', '1', '1992-12-24', '2', '2016-03-11', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('34', '1', '10', '11', '13', '2', '1983-05-31', '3', '1989-12-03', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('35', '3', '2', '1', '12', '4', '2012-08-21', '3', '1973-12-11', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('36', '3', '11', '7', '29', '4', '2006-10-24', '1', '2003-11-02', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('37', '2', '9', '5', '13', '2', '1989-12-21', '2', '2006-09-19', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('38', '2', '7', '4', '11', '2', '2014-01-10', '1', '2009-12-11', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('39', '3', '10', '11', '18', '4', '1980-08-12', '4', '2020-04-09', '2021-01-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('40', '3', '6', '4', '18', '2', '2013-05-16', '4', '1983-04-16', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('41', '1', '12', '1', '26', '3', '1972-07-22', '2', '2005-12-23', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('42', '3', '9', '1', '10', '1', '2020-01-11', '2', '1993-06-14', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('43', '2', '6', '6', '14', '2', '1978-01-19', '2', '1992-03-09', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('44', '1', '4', '1', '4', '4', '1987-03-29', '2', '1984-05-10', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('45', '1', '1', '4', '11', '1', '1981-07-07', '2', '2019-03-31', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('46', '3', '9', '6', '20', '2', '2001-07-29', '3', '1974-02-05', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('47', '2', '10', '8', '6', '2', '1988-07-02', '1', '2010-02-04', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('48', '2', '6', '8', '24', '4', '1986-12-04', '3', '2006-11-23', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('49', '2', '12', '8', '19', '1', '2000-06-11', '4', '2002-03-07', '2021-01-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('50', '1', '2', '3', '22', '4', '1978-03-20', '3', '1974-09-29', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('51', '1', '2', '4', '22', '4', '2002-09-12', '4', '1973-07-10', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('52', '1', '1', '7', '23', '2', '2008-09-28', '1', '2016-12-11', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('53', '1', '10', '6', '22', '4', '1997-04-22', '1', '1986-10-22', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('54', '3', '11', '4', '26', '1', '1998-06-28', '2', '2006-01-31', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('55', '3', '2', '12', '1', '2', '1979-04-23', '2', '2003-06-08', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('56', '1', '3', '8', '14', '1', '2007-01-16', '1', '2008-07-26', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('57', '2', '4', '10', '27', '1', '2017-12-04', '1', '1979-08-26', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('58', '3', '3', '12', '20', '1', '1997-06-11', '1', '1995-01-04', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('59', '1', '9', '1', '30', '4', '1982-01-04', '1', '2018-07-14', '2021-01-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('60', '1', '4', '9', '12', '2', '1984-11-01', '2', '2003-09-13', '2021-01-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('61', '2', '7', '1', '10', '4', '1995-11-01', '4', '1978-03-21', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('62', '3', '1', '10', '24', '2', '1979-12-08', '3', '2018-08-30', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('63', '2', '12', '12', '16', '3', '2002-09-21', '1', '2006-10-22', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('64', '2', '1', '7', '21', '2', '1987-03-24', '1', '1973-02-27', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('65', '3', '8', '11', '13', '1', '2012-12-03', '4', '1996-03-07', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('66', '3', '10', '11', '24', '4', '1997-05-27', '3', '2020-09-09', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('67', '1', '4', '12', '16', '2', '1982-10-08', '4', '1982-11-09', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('68', '3', '11', '7', '14', '4', '1985-02-01', '1', '1992-09-20', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('69', '1', '4', '3', '30', '4', '2014-06-26', '1', '1997-10-18', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('70', '3', '2', '2', '26', '4', '2008-09-10', '4', '2011-04-05', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('71', '3', '8', '3', '29', '4', '1989-12-20', '1', '1998-09-20', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('72', '1', '2', '6', '4', '1', '1993-06-02', '1', '1971-09-06', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('73', '3', '1', '9', '7', '2', '1987-05-27', '4', '1994-08-17', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('74', '1', '1', '8', '5', '1', '1984-09-05', '3', '2021-07-23', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('75', '1', '8', '9', '27', '2', '1998-09-07', '4', '1999-04-26', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('76', '1', '2', '4', '11', '1', '2001-07-23', '3', '2002-10-28', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('77', '1', '10', '1', '7', '4', '1984-10-16', '3', '1978-05-19', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('78', '1', '8', '8', '11', '3', '1970-05-01', '1', '2010-06-22', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('79', '3', '11', '7', '26', '3', '1998-05-13', '1', '2004-10-10', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('80', '3', '2', '7', '30', '1', '1993-09-13', '4', '1999-09-24', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('81', '2', '7', '10', '20', '2', '1984-09-06', '4', '1997-06-26', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('82', '1', '7', '4', '8', '1', '2016-07-15', '4', '2003-08-09', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('83', '3', '2', '2', '19', '1', '1987-06-28', '3', '1985-12-27', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('84', '2', '11', '3', '13', '4', '1978-08-04', '4', '1992-04-24', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('85', '1', '7', '9', '17', '1', '1972-01-22', '3', '1987-12-19', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('86', '2', '5', '1', '16', '4', '1994-04-03', '2', '1976-05-30', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('87', '1', '3', '5', '28', '2', '2015-08-16', '3', '1990-11-16', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('88', '1', '3', '12', '28', '1', '2003-05-07', '1', '2005-12-06', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('89', '1', '12', '9', '7', '3', '1973-11-11', '2', '1993-05-04', '2021-01-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('90', '3', '1', '12', '4', '2', '1972-08-20', '4', '1979-12-16', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('91', '1', '3', '5', '12', '2', '1985-10-06', '4', '1999-02-08', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('92', '3', '5', '10', '1', '3', '1989-09-25', '4', '2010-06-05', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('93', '3', '1', '4', '25', '4', '2002-12-12', '4', '1993-03-10', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('94', '2', '6', '10', '8', '2', '2009-12-25', '3', '2009-01-05', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('95', '3', '9', '12', '6', '4', '2002-04-07', '2', '2011-01-12', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('96', '1', '3', '11', '1', '3', '2001-12-03', '3', '1976-02-09', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('97', '1', '6', '12', '30', '2', '1984-09-19', '1', '1991-04-16', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('98', '2', '3', '10', '1', '3', '1980-04-14', '3', '2012-02-02', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('99', '1', '5', '8', '1', '1', '1972-09-18', '3', '1989-07-18', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('100', '3', '1', '10', '9', '1', '2014-06-19', '3', '2005-10-15', '2021-01-06', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('101', '3', '4', '4', '3', '3', '1975-10-23', '2', '1973-12-08', '2021-01-06', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('102', '1', '7', '10', '21', '3', '1971-11-01', '3', '2003-05-05', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('103', '2', '4', '12', '16', '3', '1996-07-10', '3', '2021-02-18', '2021-01-06', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('104', '3', '3', '10', '20', '1', '1984-02-28', '3', '1985-06-04', '2016-02-15', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('105', '2', '3', '3', '9', '2', '1979-04-01', '3', '1976-02-14', '1994-03-14', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('106', '1', '11', '5', '13', '2', '1985-11-30', '1', '1984-04-21', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('107', '1', '11', '11', '14', '1', '2020-07-09', '4', '1971-04-25', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('108', '3', '6', '7', '16', '3', '1991-10-20', '2', '1980-09-24', '2015-09-18', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('109', '3', '11', '2', '12', '1', '2010-03-08', '2', '1998-01-07', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('110', '2', '11', '1', '21', '4', '1995-05-16', '2', '2015-05-07', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('111', '1', '9', '3', '6', '3', '1973-06-02', '1', '1984-12-14', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('112', '3', '11', '8', '17', '2', '1987-12-17', '1', '1996-09-13', '1992-06-29', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('113', '1', '6', '4', '29', '2', '1978-05-29', '2', '1974-08-31', '1998-03-05', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('114', '1', '9', '12', '24', '3', '1998-03-19', '1', '2007-06-13', '1970-06-19', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('115', '2', '6', '7', '16', '1', '1991-06-24', '4', '2011-07-23', '1985-08-03', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('116', '3', '11', '5', '13', '4', '1976-06-05', '4', '1984-03-02', '1995-06-15', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('117', '1', '2', '1', '6', '3', '1976-02-10', '2', '1980-12-04', '2013-11-04', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('118', '3', '9', '6', '4', '2', '2018-10-22', '2', '1991-09-21', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('119', '1', '6', '5', '15', '4', '1984-09-23', '4', '2015-08-08', '1980-11-06', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('120', '1', '9', '9', '23', '3', '1974-11-07', '1', '1979-05-05', '1999-04-12', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('121', '2', '1', '3', '17', '1', '2001-11-21', '2', '1978-10-31', '1974-04-28', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('122', '3', '8', '11', '17', '2', '1986-12-25', '2', '1978-05-05', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('123', '3', '9', '7', '28', '1', '2009-01-05', '4', '2002-06-02', '2016-08-30', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('124', '1', '11', '5', '5', '3', '2012-04-17', '1', '2001-05-17', '2006-09-22', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('125', '1', '2', '2', '20', '1', '2005-03-18', '2', '1980-09-12', '2003-06-03', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('126', '1', '7', '11', '30', '1', '1986-04-01', '3', '1973-09-04', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('127', '2', '1', '3', '11', '3', '1978-03-12', '4', '2010-03-22', '2008-05-02', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('128', '3', '9', '8', '29', '3', '2010-07-06', '1', '1999-02-23', '2009-08-31', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('129', '1', '2', '1', '14', '1', '2018-05-13', '1', '2002-10-24', '1976-12-17', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('130', '2', '6', '4', '20', '4', '1975-02-25', '1', '1971-10-06', '2013-04-19', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('131', '1', '12', '3', '22', '4', '2016-06-17', '2', '1975-12-26', '1972-06-20', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('132', '3', '3', '5', '17', '4', '2016-12-25', '4', '2005-04-15', '2011-11-19', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('133', '2', '1', '8', '24', '1', '2005-01-07', '3', '1984-09-30', '1976-10-22', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('134', '1', '10', '5', '21', '1', '2002-04-30', '3', '2017-05-27', '1971-09-15', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('135', '1', '10', '12', '12', '4', '2013-05-28', '1', '1976-08-03', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('136', '3', '7', '3', '13', '4', '1981-05-03', '3', '2009-04-02', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('137', '3', '7', '7', '11', '3', '1992-04-04', '1', '2008-01-28', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('138', '2', '10', '5', '30', '3', '2006-04-06', '3', '1975-11-24', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('139', '3', '5', '12', '2', '1', '2021-01-03', '4', '1995-03-27', '1977-02-23', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('140', '3', '1', '7', '20', '3', '1980-12-28', '3', '1995-10-27', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('141', '2', '3', '1', '5', '3', '1986-08-23', '3', '1982-04-23', '0000-00-00', '2');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('142', '1', '9', '8', '28', '3', '1982-02-15', '1', '1981-01-28', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('143', '1', '10', '7', '1', '1', '1985-08-21', '3', '2007-02-23', '2003-04-18', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('144', '1', '6', '7', '7', '3', '2006-02-23', '1', '1993-04-06', '1984-06-25', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('145', '1', '10', '12', '18', '1', '1975-06-20', '1', '2004-02-06', '0000-00-00', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('146', '3', '7', '3', '2', '2', '2014-10-03', '4', '1982-09-02', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('147', '3', '11', '11', '29', '3', '1982-11-01', '2', '1990-08-15', '0000-00-00', '4');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('148', '3', '12', '1', '1', '2', '1992-01-25', '3', '2011-02-23', '0000-00-00', '1');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('149', '3', '8', '2', '5', '2', '1986-02-01', '1', '2019-01-13', '2008-10-20', '3');
INSERT INTO vacancies (id, implementer_id, client_id, vacancies_type_id, projects_id, grade_id, job_opening_date, priority_vacancy_id, deadline, job_closing_date, closing_vacancy_id) VALUES ('150', '2', '2', '6', '9', '3', '1981-10-22', '3', '1972-05-31', '2005-12-07', '2');

-- Генерируем данные для таблицы candidate
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('1', 'Rogahn', 'Darius', 'Jonas', '30181812064', 'ggusikowski@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('2', 'Christiansen', 'Mossie', 'Manuela', '34058402511', 'davion28@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('3', 'Gottlieb', 'Al', 'Juston', '84107313653', 'carroll.alisa@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('4', 'Stiedemann', 'Thelma', 'Devon', '91260414347', 'ckohler@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('5', 'Wisozk', 'Vanessa', 'Lamar', '70659066469', 'huels.mortimer@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('6', 'Rath', 'Savanna', 'Eldon', '81309295347', 'xlarkin@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('7', 'Koelpin', 'Johnnie', 'Devon', '12787545761', 'baron02@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('8', 'Becker', 'Joana', 'Darien', '73432699784', 'wayne51@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('9', 'VonRueden', 'Thalia', 'Joseph', '32678475128', 'gkozey@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('10', 'Hessel', 'Aniyah', 'Keith', '95841007491', 'jammie73@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('11', 'Lebsack', 'Rowena', 'Oda', '71696682951', 'kaylah.gerlach@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('12', 'Weissnat', 'Enoch', 'Anderson', '05587098657', 'vspinka@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('13', 'Rippin', 'Rahsaan', 'Lawrence', '18905366675', 'leffler.moshe@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('14', 'Crona', 'Tod', 'Laverna', '45989857279', 'brice43@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('15', 'Hagenes', 'Cortez', 'Tyreek', '38703532961', 'pouros.jimmie@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('16', 'Ankunding', 'Hollie', 'Coty', '13885633865', 'nkeebler@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('17', 'Monahan', 'Ransom', 'Melany', '05270671762', 'eldred01@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('18', 'Conroy', 'Camilla', 'Scotty', '77183466724', 'avis89@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('19', 'Dietrich', 'Daron', 'Jennings', '34121916546', 'camren66@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('20', 'Kessler', 'Leann', 'Walter', '44568652659', 'janessa30@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('21', 'Kautzer', 'Eunice', 'Manley', '78388973478', 'marquardt.antonette@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('22', 'Bahringer', 'Amari', 'Brycen', '11900882174', 'eddie.russel@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('23', 'Johnson', 'Rafaela', 'Dallin', '22762137984', 'nskiles@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('24', 'Kunze', 'Myrtice', 'Jordon', '94826442893', 'eernser@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('25', 'Beer', 'Audrey', 'Foster', '54445610163', 'tgraham@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('26', 'Macejkovic', 'Cordell', 'Kyle', '73948628447', 'joana.cartwright@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('27', 'Brakus', 'Joel', 'Skylar', '30576197125', 'rolando.glover@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('28', 'Stehr', 'Adalberto', 'Willy', '89557992060', 'randy44@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('29', 'Hauck', 'Mortimer', 'Tracey', '81603725946', 'gutmann.kathryn@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('30', 'Cruickshank', 'Dimitri', 'Otis', '12847054034', 'watsica.kendrick@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('31', 'Jacobi', 'Nelda', 'Tom', '25166208041', 'sage68@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('32', 'Kling', 'Lawrence', 'Zakary', '32651119040', 'gavin.legros@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('33', 'Dibbert', 'Donald', 'Hugh', '05702879709', 'eudora04@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('34', 'Gerlach', 'Torrance', 'Gerard', '52262452043', 'dexter38@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('35', 'Ryan', 'Willis', 'William', '94860457039', 'xrunte@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('36', 'Bednar', 'Nikolas', 'Alexis', '14196968652', 'zemlak.lemuel@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('37', 'Murray', 'Leopold', 'Urban', '16027301980', 'phomenick@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('38', 'Reichert', 'Opal', 'Ibrahim', '84642386330', 'alec12@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('39', 'Corwin', 'Grant', 'Saige', '55827980241', 'isaiah.krajcik@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('40', 'Gutmann', 'Antoinette', 'Louie', '71423350923', 'egoldner@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('41', 'Hintz', 'Aletha', 'Jose', '01142908169', 'madilyn.bergstrom@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('42', 'Ortiz', 'Loy', 'Murl', '90412905821', 'lera26@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('43', 'Rippin', 'Roxanne', 'Davion', '92994903438', 'blair.wisozk@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('44', 'Blanda', 'Carmel', 'Ari', '20963128388', 'roscoe.barton@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('45', 'Rutherford', 'Hunter', 'Rogers', '06173313167', 'jorn@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('46', 'Goodwin', 'Vada', 'Donavon', '89882164489', 'miller.rhianna@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('47', 'Abbott', 'Daniela', 'Dock', '88968430985', 'betty49@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('48', 'Douglas', 'Judy', 'Elwyn', '71506936406', 'margarete83@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('49', 'Wisozk', 'Pansy', 'Quinten', '75730429425', 'koch.edyth@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('50', 'Hyatt', 'Ned', 'Leonardo', '82834470605', 'afritsch@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('51', 'Renner', 'Walter', 'Manley', '02241701911', 'jreichel@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('52', 'Gusikowski', 'Frieda', 'Derek', '00222290456', 'miller.bins@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('53', 'Ebert', 'Dorothy', 'Davon', '80974614012', 'hessel.aurelia@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('54', 'Ernser', 'Shanelle', 'Orlo', '95494817836', 'princess90@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('55', 'Aufderhar', 'Nichole', 'Bart', '89539227532', 'marlon.reynolds@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('56', 'Swaniawski', 'Virginie', 'Jesus', '95493677620', 'marcelle81@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('57', 'Abshire', 'Cheyanne', 'Ludwig', '82909659561', 'neoma.maggio@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('58', 'Robel', 'Eryn', 'Sammy', '45582909918', 'guiseppe40@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('59', 'Stiedemann', 'Jakob', 'Tony', '06941261383', 'ryann19@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('60', 'Larkin', 'Mac', 'Avery', '21393206839', 'amy.gaylord@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('61', 'Gorczany', 'Eve', 'Dayne', '40782704279', 'jerod55@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('62', 'Stehr', 'Edmond', 'Milan', '79205669622', 'leonardo.brown@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('63', 'Spencer', 'Ernie', 'Eli', '06306657463', 'monahan.carlotta@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('64', 'Kessler', 'Osborne', 'Peter', '07782781802', 'herman.athena@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('65', 'Runte', 'Audra', 'Antone', '52775358072', 'fae11@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('66', 'Jones', 'Guido', 'Haley', '88875570339', 'maximillian82@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('67', 'Jast', 'Dorcas', 'Jose', '43239317247', 'swift.chris@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('68', 'Hodkiewicz', 'Rico', 'Omer', '07099720110', 'mberge@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('69', 'McLaughlin', 'Shyann', 'Irwin', '39705620488', 'margaret.gutmann@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('70', 'Veum', 'Bartholome', 'Giovanny', '25636518618', 'elody11@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('71', 'Denesik', 'Ari', 'Obie', '95758636245', 'freddie.bergnaum@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('72', 'Considine', 'Reynold', 'Koby', '62996633780', 'jakayla26@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('73', 'Collins', 'Obie', 'Quinn', '35694837317', 'terry.jovanny@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('74', 'Stanton', 'Danika', 'Brain', '82966806242', 'gleason.alexane@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('75', 'Baumbach', 'Retha', 'Federico', '98330381841', 'ibeahan@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('76', 'Cronin', 'Precious', 'Sylvan', '69383014410', 'mayra.rohan@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('77', 'Gulgowski', 'Odell', 'Melany', '51999182975', 'jpacocha@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('78', 'Wolf', 'Mohammad', 'Lester', '00446317080', 'augustus.jaskolski@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('79', 'Fisher', 'Giles', 'Edward', '65021042697', 'dtowne@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('80', 'Bergstrom', 'Arden', 'Dino', '32630018065', 'corbin89@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('81', 'Streich', 'Berneice', 'Bernardo', '23099657306', 'ernesto.hagenes@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('82', 'King', 'Nick', 'Keshawn', '83483481477', 'hiram.barton@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('83', 'Shields', 'Ansel', 'Theodore', '60042197009', 'pwillms@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('84', 'Legros', 'Roslyn', 'Darrion', '41248118026', 'makenna92@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('85', 'Gerlach', 'Gladyce', 'Kyle', '58681906396', 'dee09@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('86', 'Kuhlman', 'Madelyn', 'Ellsworth', '83372661447', 'lue35@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('87', 'Ankunding', 'Everett', 'Tito', '38289236703', 'qquigley@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('88', 'Nicolas', 'Tremaine', 'Moses', '67166545097', 'hpfeffer@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('89', 'Nikolaus', 'Ophelia', 'Josh', '32722035713', 'yhansen@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('90', 'Baumbach', 'Pablo', 'Angus', '78536182007', 'qdickens@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('91', 'Waelchi', 'Pasquale', 'Evans', '03452954463', 'ines94@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('92', 'Schaden', 'Asa', 'Conner', '76100979373', 'lebsack.rosa@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('93', 'Schuster', 'Mary', 'Kennedy', '47690058174', 'althea.hoppe@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('94', 'Kohler', 'Margarita', 'Keegan', '84675984778', 'beer.sherman@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('95', 'Cormier', 'Ashtyn', 'Randal', '31873477918', 'kunze.seamus@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('96', 'Mosciski', 'Lou', 'Forrest', '29004382082', 'pfranecki@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('97', 'Nolan', 'Bret', 'Jeramy', '13913061620', 'zieme.vicenta@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('98', 'Hackett', 'Lavinia', 'Jadon', '63456753108', 'ehansen@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('99', 'Fritsch', 'Bernita', 'Norberto', '64301825581', 'leffler.mabel@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('100', 'Padberg', 'Frieda', 'Franz', '30494078510', 'kamron.ryan@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('101', 'Hills', 'Paxton', 'Sheldon', '15191658840', 'clement32@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('102', 'Wintheiser', 'Delfina', 'Karson', '41043093068', 'qmedhurst@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('103', 'Stokes', 'Adriel', 'Tyreek', '34354013173', 'shad.harvey@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('104', 'Becker', 'Cayla', 'Liam', '27090940462', 'era.walter@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('105', 'Flatley', 'Cheyanne', 'Aric', '11470373205', 'gwen25@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('106', 'Kerluke', 'Tomasa', 'Sherman', '01664765689', 'jarvis82@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('107', 'Grady', 'Rylan', 'Tobin', '21439298014', 'cerdman@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('108', 'Weimann', 'Loyal', 'Llewellyn', '67459380984', 'howe.rollin@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('109', 'Bogisich', 'Rocio', 'Vaughn', '55381844501', 'nluettgen@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('110', 'Wintheiser', 'Vaughn', 'Tavares', '42486625883', 'ahoppe@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('111', 'Moen', 'Jeanne', 'Skylar', '76850922762', 'champlin.minnie@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('112', 'Kiehn', 'Mariane', 'Jaylin', '75857574549', 'herzog.forrest@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('113', 'Batz', 'Humberto', 'Gerardo', '70397580407', 'elwin.stehr@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('114', 'Nicolas', 'Modesta', 'Elliot', '72268170189', 'hope.vandervort@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('115', 'Schulist', 'Alexzander', 'Alexzander', '44100496929', 'emccullough@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('116', 'Green', 'Annabel', 'Liam', '65522111302', 'vivien.murphy@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('117', 'Kreiger', 'Stella', 'Terrance', '55157979430', 'tdouglas@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('118', 'Reichel', 'Pamela', 'Tito', '17454981319', 'uberge@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('119', 'Macejkovic', 'Deshawn', 'Harmon', '71417250370', 'kaden14@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('120', 'Armstrong', 'Tyler', 'Irving', '07882504676', 'leannon.shemar@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('121', 'Douglas', 'Myrl', 'Laverne', '06089536474', 'ibalistreri@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('122', 'Donnelly', 'Rex', 'Joel', '19517285954', 'benjamin.stamm@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('123', 'Cremin', 'Nora', 'Trystan', '75483768323', 'kyost@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('124', 'Cremin', 'Torrance', 'Melvina', '88945717145', 'haag.aryanna@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('125', 'Mills', 'Alyson', 'Rocio', '63574613198', 'ryann.predovic@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('126', 'Dach', 'Marianna', 'Faustino', '07434000962', 'cdurgan@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('127', 'Davis', 'Aaliyah', 'Wellington', '74394793644', 'gislason.izaiah@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('128', 'Parker', 'Damien', 'Carson', '46691676319', 'mekhi90@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('129', 'Maggio', 'Demetris', 'Roel', '44113374709', 'klocko.winnifred@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('130', 'Ritchie', 'Zola', 'Zachariah', '19871081017', 'rolfson.tyreek@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('131', 'Emmerich', 'Robin', 'Tod', '24402493463', 'maxie58@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('132', 'Sauer', 'Marian', 'Kade', '54325433733', 'hansen.herminio@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('133', 'Daugherty', 'Burnice', 'Ola', '79050865787', 'keeling.shanelle@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('134', 'Roberts', 'Abigale', 'Al', '76441250794', 'qconn@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('135', 'Russel', 'Esperanza', 'Afton', '60110515517', 'lkeebler@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('136', 'Stiedemann', 'Cydney', 'Cristopher', '73623555064', 'keeling.orlo@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('137', 'Gottlieb', 'Hazel', 'Jerad', '87611504386', 'hoppe.wellington@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('138', 'Schaden', 'Mckayla', 'Rahul', '21756127981', 'eddie96@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('139', 'Luettgen', 'Daron', 'Anastacio', '35773483157', 'hyman26@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('140', 'Hermann', 'Zetta', 'Deron', '33855799610', 'jamir93@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('141', 'Abernathy', 'Ulises', 'Carmelo', '92379818967', 'watsica.kamron@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('142', 'Herman', 'Gladyce', 'Prince', '43839316753', 'andreanne67@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('143', 'Macejkovic', 'Abigail', 'Gennaro', '12893605717', 'cartwright.cydney@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('144', 'Kunze', 'Eliane', 'Jeremie', '34305925779', 'kaia.schneider@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('145', 'Feil', 'Ayla', 'Lucious', '82396022396', 'bmitchell@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('146', 'Auer', 'Viviane', 'Demetrius', '06583705620', 'crystel83@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('147', 'Feest', 'Fabian', 'Stefan', '29560782978', 'waino19@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('148', 'Franecki', 'Edyth', 'Arvel', '26382304688', 'timmothy.rutherford@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('149', 'Heidenreich', 'Alexzander', 'Joan', '56747187922', 'sbeahan@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('150', 'Pfannerstill', 'Urban', 'Jalon', '61890346642', 'brant71@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('151', 'Dibbert', 'Nestor', 'Seamus', '94795077734', 'corrine51@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('152', 'Wisoky', 'Norma', 'Garnett', '71814278082', 'nash.welch@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('153', 'Reichert', 'Raven', 'Bennett', '30680994934', 'ashton48@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('154', 'O\'Kon', 'Lorena', 'Tony', '57867780562', 'malcolm.gerhold@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('155', 'Senger', 'Carlee', 'Cesar', '24589686850', 'marielle.labadie@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('156', 'Olson', 'Dewayne', 'Clovis', '14288469942', 'powlowski.shea@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('157', 'Effertz', 'Mitchel', 'Jordy', '84241023598', 'cassidy03@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('158', 'Fisher', 'Karolann', 'Brando', '33267455510', 'ahmed.jaskolski@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('159', 'Jenkins', 'Earlene', 'Murphy', '92205189211', 'abednar@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('160', 'Armstrong', 'Rory', 'Sonny', '99611509958', 'crawford95@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('161', 'Koepp', 'Yoshiko', 'Dane', '82288038840', 'wyman31@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('162', 'Blick', 'Johnathan', 'Joshuah', '26929909402', 'ischuppe@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('163', 'Hyatt', 'Leslie', 'Franz', '86671301996', 'lowell.bahringer@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('164', 'Borer', 'Collin', 'Ford', '42941613984', 'kennedi.barton@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('165', 'Swift', 'Candido', 'Angus', '62769971604', 'connie73@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('166', 'Konopelski', 'Stephany', 'Muhammad', '60291957392', 'zbotsford@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('167', 'Wiza', 'Haven', 'Dudley', '00107288339', 'graham.kristina@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('168', 'Koch', 'Coy', 'Garrison', '53899335418', 'grady.isac@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('169', 'Bergnaum', 'Brianne', 'Chaim', '20278721137', 'ewell.heller@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('170', 'Reichel', 'Tia', 'Chadrick', '94266867891', 'charity57@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('171', 'Sporer', 'Wilhelmine', 'Walker', '52852038832', 'ibins@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('172', 'Rodriguez', 'Vada', 'Rigoberto', '76609176851', 'ferry.bret@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('173', 'Cartwright', 'Ashlynn', 'Roscoe', '05990086306', 'maybell71@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('174', 'Pfannerstill', 'Cory', 'Kevon', '71337750807', 'rhegmann@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('175', 'Cummerata', 'Palma', 'Odell', '33573790923', 'eldridge14@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('176', 'Rippin', 'Frederik', 'Tyrell', '00632598736', 'rubie.goyette@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('177', 'Hickle', 'Douglas', 'Lambert', '64595331878', 'roel56@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('178', 'Mayert', 'Barney', 'Jordy', '09905864457', 'rachel.witting@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('179', 'Welch', 'Giovani', 'Cielo', '32934027887', 'keon.jacobi@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('180', 'Schmidt', 'Laurel', 'Jason', '66279739909', 'annabell01@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('181', 'Koelpin', 'Isobel', 'Angus', '40951186316', 'mdare@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('182', 'Cummerata', 'Caden', 'Hubert', '30676271459', 'gaston12@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('183', 'Upton', 'Ernestine', 'Eladio', '60596283884', 'dterry@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('184', 'Abbott', 'Emerson', 'Eddie', '52346172027', 'aufderhar.dorothy@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('185', 'Kshlerin', 'Sally', 'Randi', '31034121502', 'dmayert@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('186', 'Schultz', 'Katarina', 'Ervin', '73359725261', 'treutel.sanford@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('187', 'Kuphal', 'Marietta', 'Nathan', '19361350855', 'neha.muller@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('188', 'Larson', 'Eloisa', 'Jesus', '47483290322', 'antonia90@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('189', 'Thiel', 'Florida', 'Ron', '92639537183', 'hodkiewicz.wendy@example.net');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('190', 'Herman', 'Addie', 'Caesar', '69481071143', 'crystal.heathcote@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('191', 'Bauch', 'Chauncey', 'Hillard', '87007148289', 'jaycee45@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('192', 'Bashirian', 'Rhea', 'Monroe', '50409995439', 'bergstrom.isom@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('193', 'Wunsch', 'Lizeth', 'Armand', '25014118903', 'lia.hodkiewicz@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('194', 'Wilkinson', 'Citlalli', 'Tillman', '18676854631', 'donny60@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('195', 'Armstrong', 'Evert', 'Jakob', '08909798025', 'stefan23@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('196', 'Stracke', 'Gladyce', 'Andy', '11819268369', 'franecki.domenica@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('197', 'Graham', 'Nils', 'Ahmed', '60231112120', 'qrosenbaum@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('198', 'Hauck', 'Annie', 'Jose', '09429138555', 'adelle57@example.org');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('199', 'Beahan', 'Louie', 'Werner', '30965210130', 'paxton05@example.com');
INSERT INTO candidate (id, surname, name, middle_name, telephone, email) VALUES ('200', 'Wintheiser', 'Alize', 'Trystan', '65812985562', 'jerde.leone@example.com');

-- Генерируем данные для таблицы candidate_data
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('1', '2006-07-06', 'м', 'Christland', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('2', '1971-04-29', 'м', 'Steuberside', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('3', '1985-12-08', 'ж', 'Stoltenberghaven', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('4', '2000-05-18', 'м', 'Douglasburgh', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('5', '1977-04-08', 'ж', 'Arlenefurt', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('6', '2005-02-24', 'ж', 'Valentinaland', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('7', '1989-10-23', 'м', 'Port Leslieburgh', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('8', '2007-10-31', 'м', 'Harberside', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('9', '2011-09-02', 'ж', 'Concepcionview', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('10', '2016-03-03', 'ж', 'New Retta', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('11', '2004-09-17', 'м', 'Collierburgh', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('12', '1983-11-05', 'м', 'North Majorshire', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('13', '2010-08-09', 'ж', 'Harberberg', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('14', '1978-04-03', 'ж', 'Legrosbury', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('15', '2009-12-31', 'м', 'South Jody', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('16', '2004-12-08', 'ж', 'North Marty', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('17', '2017-02-20', 'ж', 'North Fanny', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('18', '1982-05-25', 'ж', 'Skilesburgh', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('19', '1973-02-02', 'м', 'Port Juana', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('20', '1973-11-09', 'ж', 'Aileenhaven', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('21', '1999-01-02', 'ж', 'Bergetown', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('22', '1987-04-05', 'ж', 'Ziemechester', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('23', '2011-07-15', 'ж', 'Schmitthaven', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('24', '2021-06-03', 'м', 'Conroyhaven', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('25', '1993-07-29', 'ж', 'Schoenfort', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('26', '1977-10-04', 'м', 'New Grover', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('27', '2004-09-04', 'ж', 'Kyleighside', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('28', '1978-10-17', 'ж', 'Padbergshire', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('29', '1979-05-10', 'м', 'DuBuqueport', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('30', '2004-04-04', 'м', 'West Johnniechester', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('31', '1979-01-21', 'ж', 'North Francesfort', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('32', '1979-05-26', 'ж', 'Wolfside', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('33', '1983-05-09', 'ж', 'New Gia', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('34', '1975-06-08', 'ж', 'Hintzfurt', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('35', '2004-11-17', 'м', 'East Rick', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('36', '1976-04-29', 'м', 'Langberg', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('37', '2012-06-24', 'ж', 'East Maxineside', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('38', '1993-06-12', 'ж', 'North Nathantown', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('39', '1996-06-29', 'м', 'South Sybleport', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('40', '1986-11-22', 'ж', 'Russelborough', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('41', '1993-09-27', 'ж', 'Fisherton', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('42', '1979-04-23', 'м', 'Lake Jasperburgh', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('43', '1979-05-31', 'ж', 'North Ethelynport', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('44', '1980-01-10', 'м', 'West Mauricio', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('45', '2018-02-09', 'м', 'Doyleton', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('46', '1983-01-29', 'м', 'Bartolettifurt', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('47', '2000-12-02', 'м', 'New Cassandre', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('48', '1977-12-30', 'м', 'Howetown', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('49', '1994-02-16', 'ж', 'Teresafurt', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('50', '1987-01-14', 'ж', 'New Alejandraside', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('51', '1970-10-25', 'ж', 'South Lilliehaven', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('52', '2007-08-25', 'ж', 'Parisianton', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('53', '2016-01-11', 'ж', 'Olsonville', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('54', '2009-02-11', 'м', 'East Alvina', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('55', '1990-08-03', 'ж', 'Lueilwitzton', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('56', '1992-07-31', 'м', 'Gleasonbury', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('57', '1970-01-21', 'м', 'East Hector', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('58', '1988-04-19', 'м', 'West Andreanne', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('59', '1991-01-28', 'ж', 'Port Bret', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('60', '2009-12-19', 'м', 'New Hillarymouth', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('61', '2013-02-04', 'ж', 'New Christa', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('62', '2000-01-21', 'ж', 'Thompsonchester', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('63', '1982-08-10', 'ж', 'South Darryl', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('64', '1985-12-01', 'м', 'Port Clarissaburgh', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('65', '1977-10-12', 'м', 'New Rubieville', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('66', '1981-05-11', 'м', 'West Eastermouth', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('67', '1990-06-18', 'ж', 'Ernsertown', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('68', '1978-11-03', 'ж', 'Jerdeborough', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('69', '1980-12-25', 'м', 'Graysonhaven', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('70', '2015-12-11', 'м', 'Port Hermantown', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('71', '1977-02-04', 'м', 'Jonesside', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('72', '1978-04-05', 'ж', 'Goldnertown', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('73', '1977-10-01', 'ж', 'South Leoraview', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('74', '1989-08-25', 'ж', 'Port Richiestad', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('75', '1985-07-21', 'ж', 'Bartolettiton', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('76', '1975-06-17', 'м', 'Gibsonhaven', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('77', '1970-08-04', 'м', 'Millerview', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('78', '1975-12-11', 'ж', 'North Chazchester', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('79', '2001-07-30', 'ж', 'Jalynview', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('80', '2000-01-20', 'ж', 'Richieburgh', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('81', '1995-08-25', 'м', 'Lynchberg', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('82', '1987-07-03', 'ж', 'Lake Coltenmouth', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('83', '1977-03-05', 'м', 'Weissnatland', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('84', '1988-02-10', 'ж', 'Lake Kaylahville', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('85', '1994-04-04', 'м', 'North Mercedesview', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('86', '1986-09-21', 'ж', 'Turnerview', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('87', '2002-02-13', 'м', 'West Jarenmouth', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('88', '2000-03-28', 'ж', 'Schinnerfurt', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('89', '1970-02-10', 'ж', 'Cristalburgh', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('90', '2019-07-19', 'ж', 'Lake Thalia', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('91', '2010-06-05', 'ж', 'North Kay', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('92', '1995-03-25', 'м', 'Schmelerfurt', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('93', '1979-04-29', 'м', 'Lake Lemuel', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('94', '1972-12-12', 'ж', 'Ivabury', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('95', '1994-05-06', 'м', 'Kuhlmantown', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('96', '2007-04-29', 'м', 'East Janice', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('97', '1986-08-11', 'м', 'Luciomouth', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('98', '1994-05-05', 'м', 'Leonorafort', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('99', '1984-07-06', 'м', 'Hilpertfort', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('100', '1982-03-11', 'ж', 'Greenton', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('101', '1973-02-08', 'м', 'Gottliebport', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('102', '2018-12-22', 'м', 'Lake Rudy', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('103', '2016-04-05', 'м', 'Croninhaven', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('104', '2002-04-19', 'м', 'Jastberg', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('105', '1999-09-22', 'ж', 'Smithview', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('106', '1986-01-11', 'м', 'VonRuedenborough', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('107', '1996-03-24', 'ж', 'West Randyton', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('108', '1979-06-05', 'м', 'Port Dillonburgh', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('109', '2004-12-22', 'ж', 'East Rocky', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('110', '1983-04-25', 'ж', 'West Kristaport', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('111', '1999-03-27', 'ж', 'Lake Trevorburgh', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('112', '2004-03-24', 'ж', 'Maegantown', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('113', '1999-03-18', 'ж', 'West Cyril', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('114', '2012-03-30', 'ж', 'Auerville', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('115', '1997-04-17', 'м', 'Bethmouth', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('116', '2010-10-06', 'ж', 'Aubreestad', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('117', '1997-08-20', 'м', 'Brownton', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('118', '1990-12-17', 'м', 'Kaciebury', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('119', '1993-01-26', 'ж', 'Grahamborough', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('120', '2015-10-07', 'ж', 'Port Cordia', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('121', '1971-02-01', 'м', 'New Aimeeview', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('122', '1994-05-08', 'м', 'Marlonborough', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('123', '1986-08-30', 'м', 'Lake Duane', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('124', '1985-11-02', 'ж', 'Hazelstad', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('125', '1997-12-17', 'м', 'Lake Marlen', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('126', '1998-10-14', 'ж', 'Ceasarmouth', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('127', '1981-09-16', 'ж', 'East Tristin', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('128', '1986-01-17', 'ж', 'Maxwellbury', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('129', '1984-10-30', 'ж', 'Breitenbergland', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('130', '2001-06-29', 'м', 'Pfeffershire', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('131', '1998-08-20', 'м', 'North Tianamouth', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('132', '2009-02-19', 'м', 'Lake Moshe', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('133', '1970-02-16', 'ж', 'Lake Otto', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('134', '2016-06-30', 'м', 'Kihnmouth', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('135', '2012-01-20', 'м', 'Nienowville', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('136', '1979-10-14', 'м', 'Langworthfurt', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('137', '2017-02-02', 'м', 'New Lambert', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('138', '1975-02-17', 'ж', 'Greenholtshire', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('139', '2012-11-18', 'м', 'Ernestinaberg', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('140', '1983-07-27', 'м', 'New Mauricio', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('141', '1997-11-10', 'м', 'New Carissa', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('142', '2014-11-09', 'м', 'East Roelburgh', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('143', '1996-08-05', 'м', 'East Jameson', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('144', '1984-10-11', 'ж', 'Dewitthaven', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('145', '2012-02-01', 'м', 'North Cordell', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('146', '1979-09-30', 'ж', 'Port Felipe', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('147', '1981-04-29', 'м', 'East Adelineville', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('148', '1983-10-24', 'ж', 'Parkerton', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('149', '1985-08-27', 'м', 'Corkeryborough', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('150', '1986-10-03', 'ж', 'New Cierra', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('151', '1979-11-20', 'м', 'Rebabury', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('152', '1989-02-12', 'ж', 'Marinafort', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('153', '1970-04-02', 'ж', 'Handland', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('154', '1999-06-25', 'м', 'Wildermanborough', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('155', '1989-12-23', 'ж', 'Faychester', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('156', '2006-04-22', 'ж', 'Lenorastad', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('157', '2017-02-08', 'м', 'Lake Ted', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('158', '2009-03-02', 'ж', 'Port Loraineberg', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('159', '2006-06-16', 'ж', 'Wadehaven', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('160', '2010-07-19', 'м', 'New Antoinette', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('161', '1991-10-08', 'ж', 'Lake Cletafort', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('162', '2001-09-09', 'м', 'Port Rodrigo', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('163', '2011-11-21', 'ж', 'Jerdeberg', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('164', '1985-09-28', 'ж', 'Lake Khalid', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('165', '1988-07-25', 'ж', 'North Lela', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('166', '2012-09-30', 'м', 'Darrylfort', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('167', '2007-12-27', 'м', 'South Bufordbury', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('168', '1971-02-08', 'ж', 'Johnsbury', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('169', '2010-05-28', 'м', 'Port Evalynton', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('170', '2006-11-01', 'м', 'Wolffhaven', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('171', '1997-01-24', 'ж', 'Kuhicview', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('172', '1986-08-14', 'м', 'North Maverickland', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('173', '1982-08-15', 'ж', 'East Ludwigborough', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('174', '2009-08-22', 'ж', 'East Ethelside', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('175', '2003-02-05', 'м', 'Edenberg', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('176', '2011-05-08', 'м', 'New Margeport', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('177', '2000-09-03', 'ж', 'Lambertville', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('178', '1980-10-14', 'ж', 'East Wyman', 'нет', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('179', '2009-04-07', 'м', 'Port Leochester', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('180', '1970-06-07', 'ж', 'Lake Josiah', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('181', '1982-08-22', 'м', 'Vitostad', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('182', '2012-11-10', 'ж', 'Port Elbert', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('183', '2001-12-07', 'м', 'Isaacchester', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('184', '2000-09-26', 'м', 'New Heberton', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('185', '2002-01-22', 'ж', 'Erdmanberg', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('186', '2010-06-10', 'м', 'South Meganehaven', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('187', '1990-02-25', 'м', 'Faustinomouth', 'нет', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('188', '2001-07-10', 'м', 'South Robbieville', 'да', ' Женат/Замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('189', '1997-08-31', 'ж', 'East Agustin', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('190', '2018-08-15', 'ж', 'East Rosaport', 'да', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('191', '2020-12-19', 'ж', 'Bartellfurt', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('192', '1979-08-05', 'м', 'Jerrodton', 'нет', ' Холост/Не замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('193', '1996-08-14', 'м', 'Gloverland', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('194', '2001-01-17', 'м', 'South Lelah', 'да', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('195', '1991-04-10', 'ж', 'Port Davonport', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('196', '1985-10-07', 'м', 'Rigobertohaven', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('197', '1996-01-02', 'м', 'Juvenalfort', 'нет', ' Холост/Не замужем', '5/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('198', '1977-12-14', 'ж', 'Reingerside', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('199', '2016-05-18', 'ж', 'North Augustine', 'да', ' Женат/Замужем', '2/2');
INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES ('200', '1976-11-15', 'м', 'Abigaylebury', 'нет', ' Холост/Не замужем', '5/2');

-- Генерируем данные для таблицы position_of_candidates
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('1', '1', '4', '1', '291882', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('2', '6', '10', '6', '94373', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('3', '9', '4', '4', '78684', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('4', '2', '3', '9', '161778', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('5', '12', '2', '7', '300551', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('6', '11', '3', '9', '113862', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('7', '5', '9', '4', '241549', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('8', '6', '7', '6', '118065', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('9', '8', '3', '6', '322039', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('10', '4', '4', '2', '322650', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('11', '2', '8', '8', '421937', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('12', '6', '9', '3', '65532', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('13', '6', '3', '6', '244809', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('14', '9', '5', '7', '441480', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('15', '8', '2', '3', '206673', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('16', '6', '', '6', '69389', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('17', '9', '1', '', '105808', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('18', '2', '7', '', '196870', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('19', '6', '2', '4', '205949', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('20', '4', '8', '9', '415252', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('21', '8', '10', '5', '233785', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('22', '1', '6', '8', '372425', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('23', '12', '1', '2', '437379', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('24', '7', '9', '7', '430258', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('25', '11', '3', '', '386615', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('26', '8', '', '', '285718', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('27', '8', '1', '3', '112965', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('28', '12', '10', '9', '94721', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('29', '1', '10', '6', '360710', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('30', '2', '2', '3', '132768', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('31', '4', '2', '10', '181257', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('32', '2', '4', '7', '322685', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('33', '8', '5', '1', '179406', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('34', '12', '', '1', '60731', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('35', '4', '1', '3', '52344', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('36', '7', '6', '8', '223121', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('37', '11', '7', '4', '245023', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('38', '8', '1', '2', '284400', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('39', '12', '6', '6', '102815', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('40', '7', '1', '6', '344897', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('41', '11', '3', '10', '71546', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('42', '1', '6', '5', '418396', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('43', '12', '3', '5', '246421', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('44', '4', '6', '10', '145075', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('45', '9', '9', '2', '448798', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('46', '8', '9', '8', '144839', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('47', '10', '7', '7', '434991', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('48', '6', '3', '', '325526', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('49', '9', '10', '7', '69668', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('50', '4', '2', '', '272853', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('51', '10', '7', '8', '221396', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('52', '5', '4', '', '170621', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('53', '5', '9', '10', '148195', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('54', '9', '10', '4', '229354', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('55', '11', '2', '6', '112240', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('56', '3', '10', '7', '277208', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('57', '4', '6', '4', '100767', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('58', '7', '5', '9', '60446', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('59', '3', '2', '1', '70899', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('60', '5', '5', '3', '76572', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('61', '8', '2', '7', '367047', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('62', '7', '4', '9', '235077', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('63', '6', '7', '1', '387263', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('64', '4', '2', '9', '205202', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('65', '7', '6', '8', '75018', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('66', '9', '4', '3', '304646', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('67', '10', '8', '7', '59032', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('68', '5', '', '7', '434662', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('69', '5', '2', '', '70193', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('70', '9', '8', '10', '279570', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('71', '11', '10', '1', '310515', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('72', '3', '10', '6', '446689', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('73', '10', '8', '5', '306428', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('74', '10', '5', '4', '321206', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('75', '7', '9', '7', '445128', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('76', '7', '3', '5', '444496', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('77', '6', '7', '1', '90834', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('78', '4', '3', '3', '419599', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('79', '12', '4', '9', '432868', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('80', '2', '6', '8', '237605', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('81', '8', '3', '6', '225211', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('82', '9', '4', '8', '119332', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('83', '7', '9', '4', '141587', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('84', '12', '8', '', '250937', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('85', '6', '9', '3', '60322', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('86', '6', '2', '6', '283158', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('87', '3', '4', '9', '265476', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('88', '9', '4', '3', '437668', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('89', '12', '8', '8', '427625', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('90', '6', '6', '', '376154', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('91', '2', '5', '6', '325046', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('92', '8', '2', '9', '291840', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('93', '12', '10', '1', '291438', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('94', '8', '', '2', '119913', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('95', '11', '3', '8', '90688', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('96', '6', '6', '9', '80473', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('97', '5', '6', '5', '68419', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('98', '8', '8', '5', '243930', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('99', '11', '7', '4', '197185', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('100', '9', '6', '4', '404718', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('101', '5', '8', '5', '270347', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('102', '9', '1', '8', '121308', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('103', '11', '', '2', '263823', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('104', '3', '2', '5', '75208', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('105', '7', '5', '10', '65610', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('106', '6', '6', '10', '345965', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('107', '9', '5', '4', '425257', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('108', '12', '1', '7', '310231', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('109', '10', '5', '1', '71621', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('110', '9', '9', '10', '281396', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('111', '2', '3', '', '140713', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('112', '5', '10', '8', '271192', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('113', '5', '', '2', '278842', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('114', '8', '5', '3', '136926', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('115', '4', '7', '6', '190716', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('116', '10', '6', '3', '417345', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('117', '1', '4', '6', '350151', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('118', '7', '4', '10', '383575', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('119', '7', '8', '1', '319125', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('120', '12', '7', '7', '252996', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('121', '12', '2', '', '443446', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('122', '9', '7', '4', '270704', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('123', '7', '2', '6', '123527', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('124', '12', '9', '6', '181522', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('125', '4', '9', '8', '193750', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('126', '5', '3', '8', '332916', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('127', '5', '4', '3', '219846', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('128', '8', '7', '8', '120407', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('129', '1', '', '10', '52094', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('130', '4', '9', '2', '383698', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('131', '5', '6', '5', '347070', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('132', '6', '', '6', '295034', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('133', '12', '6', '', '346382', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('134', '4', '9', '9', '111449', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('135', '8', '3', '10', '222404', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('136', '7', '', '3', '378612', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('137', '9', '9', '9', '235094', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('138', '4', '2', '7', '87314', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('139', '6', '9', '9', '101140', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('140', '6', '10', '7', '159769', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('141', '1', '', '5', '320850', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('142', '8', '4', '2', '299268', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('143', '11', '2', '1', '356987', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('144', '5', '', '2', '212581', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('145', '3', '9', '', '218534', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('146', '2', '7', '7', '264098', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('147', '3', '1', '8', '355842', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('148', '3', '8', '9', '237344', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('149', '9', '7', '5', '391317', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('150', '10', '', '', '348379', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('151', '3', '6', '4', '221162', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('152', '8', '5', '9', '397509', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('153', '6', '4', '9', '111111', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('154', '9', '5', '4', '101023', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('155', '8', '3', '4', '280002', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('156', '10', '6', '6', '86719', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('157', '2', '', '', '256581', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('158', '12', '1', '8', '340506', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('159', '6', '2', '1', '135416', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('160', '3', '10', '9', '411703', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('161', '4', '8', '9', '183200', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('162', '10', '1', '2', '385999', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('163', '8', '', '9', '177381', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('164', '4', '7', '8', '300288', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('165', '1', '3', '10', '364856', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('166', '3', '8', '8', '311128', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('167', '10', '2', '7', '73893', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('168', '9', '9', '6', '263529', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('169', '7', '3', '1', '438004', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('170', '4', '2', '1', '435791', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('171', '3', '', '2', '276945', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('172', '7', '10', '4', '391800', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('173', '11', '7', '9', '101070', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('174', '1', '7', '10', '185651', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('175', '12', '2', '3', '78914', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('176', '1', '10', '7', '443006', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('177', '3', '5', '', '296990', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('178', '3', '6', '8', '234378', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('179', '4', '6', '7', '200882', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('180', '11', '3', '', '256809', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('181', '1', '1', '5', '417047', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('182', '6', '9', '2', '52816', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('183', '7', '10', '5', '251520', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('184', '6', '7', '4', '316953', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('185', '3', '4', '5', '365755', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('186', '2', '3', '8', '236229', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('187', '4', '6', '6', '397488', 'EUR');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('188', '4', '1', '4', '76871', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('189', '2', '1', '3', '289529', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('190', '9', '4', '10', '105976', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('191', '7', '1', '6', '242655', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('192', '5', '9', '10', '417457', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('193', '6', '10', '4', '150262', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('194', '2', '5', '4', '359533', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('195', '8', '1', '7', '195704', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('196', '7', '', '', '407041', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('197', '5', '8', '', '53140', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('198', '6', '7', '9', '446315', 'RUB');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('199', '4', '10', '3', '425074', 'USD');
INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency) VALUES ('200', '12', '3', '1', '424213', 'EUR');

-- Генерируем данные для таблицы сandidate_status
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('1', '11', '1993-08-19', '1', '1986-05-27', '3', '2001-03-05');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('2', '2', '1993-03-03', '1', '2000-01-10', '1', '2009-09-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('3', '6', '2013-12-04', '1', '2018-12-06', '3', '1982-11-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('4', '3', '1995-09-14', '2', '1988-07-15', '2', '1991-05-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('5', '6', '2013-11-21', '3', '2012-06-16', '1', '1997-12-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('6', '7', '2006-03-17', '4', '1981-02-10', '1', '1982-02-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('7', '8', '1999-02-18', '6', '2016-11-09', '3', '1977-10-15');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('8', '12', '2010-07-20', '2', '1992-04-15', '2', '2005-03-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('9', '12', '1987-03-18', '8', '1992-06-30', '3', '1982-04-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('10', '3', '2012-08-23', '3', '1978-06-02', '2', '1985-10-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('11', '5', '2017-07-23', '1', '2008-12-26', '2', '1976-10-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('12', '3', '1984-12-08', '7', '1999-02-22', '3', '1990-09-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('13', '12', '1976-05-17', '8', '1995-09-29', '3', '1973-09-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('14', '12', '2016-07-24', '5', '2021-01-20', '2', '2015-04-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('15', '2', '1982-02-08', '5', '2010-03-18', '3', '2019-02-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('16', '1', '1987-12-25', '8', '2020-09-19', '1', '2018-12-05');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('17', '11', '2001-03-19', '4', '2007-03-10', '3', '1995-04-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('18', '1', '1970-10-30', '5', '1983-03-02', '3', '1989-05-26');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('19', '11', '2013-01-19', '8', '1973-06-28', '3', '2017-03-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('20', '4', '2017-06-10', '4', '2009-04-19', '1', '1998-03-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('21', '11', '2013-04-25', '2', '2008-11-10', '2', '1982-08-24');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('22', '3', '2011-10-22', '1', '1995-05-30', '1', '2012-11-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('23', '10', '1992-01-01', '5', '2020-05-08', '1', '2021-07-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('24', '10', '2006-08-27', '2', '1977-07-30', '1', '2001-07-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('25', '10', '1996-09-04', '5', '2002-03-11', '1', '2017-05-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('26', '6', '1981-04-07', '6', '1986-01-03', '1', '1975-05-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('27', '5', '1997-10-05', '5', '1973-07-14', '2', '2020-12-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('28', '12', '1985-04-23', '6', '1998-12-16', '3', '1984-10-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('29', '6', '1987-12-20', '8', '2019-04-07', '2', '1988-10-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('30', '7', '2016-12-28', '7', '1998-05-21', '1', '2008-09-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('31', '6', '1986-03-23', '2', '2007-12-07', '2', '1973-09-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('32', '4', '1988-03-20', '3', '1989-03-09', '3', '2015-04-15');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('33', '8', '1974-08-29', '4', '1970-09-05', '1', '2002-11-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('34', '4', '2013-08-01', '4', '1977-02-07', '2', '1988-09-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('35', '10', '2006-10-16', '1', '2011-08-29', '1', '2005-07-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('36', '7', '1985-10-30', '6', '1973-06-15', '2', '1991-10-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('37', '12', '1995-12-02', '5', '2001-11-24', '2', '1996-07-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('38', '9', '2020-11-08', '3', '2009-02-20', '3', '2002-11-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('39', '10', '2015-06-25', '2', '2010-01-18', '2', '1981-02-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('40', '9', '2008-02-09', '2', '2021-03-12', '1', '1994-03-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('41', '3', '1976-01-13', '2', '2015-07-23', '2', '1989-04-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('42', '7', '1974-09-22', '1', '1991-11-13', '2', '2007-09-05');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('43', '10', '1979-05-19', '2', '1978-01-21', '1', '1973-07-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('44', '9', '1970-08-14', '3', '1994-12-14', '2', '2001-10-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('45', '1', '1989-11-11', '3', '1979-10-25', '1', '1971-03-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('46', '4', '1979-08-22', '8', '2017-04-30', '1', '2019-12-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('47', '10', '1999-08-22', '4', '1973-10-24', '3', '2001-07-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('48', '1', '1975-10-28', '2', '2008-12-24', '2', '1994-08-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('49', '10', '1984-10-09', '1', '2007-02-25', '2', '1973-08-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('50', '11', '1980-04-01', '7', '1996-07-17', '3', '2013-02-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('51', '3', '1988-07-26', '7', '1974-06-03', '3', '1989-04-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('52', '3', '1991-03-23', '7', '1971-12-14', '1', '2017-06-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('53', '8', '1995-10-24', '3', '1989-06-26', '2', '2014-02-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('54', '4', '2012-01-09', '4', '1988-09-07', '2', '1991-09-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('55', '5', '2017-05-23', '1', '1972-02-18', '2', '1998-04-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('56', '12', '1980-05-13', '8', '2004-07-24', '1', '1983-09-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('57', '1', '1989-04-02', '4', '1989-04-29', '3', '1998-07-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('58', '12', '1998-08-04', '3', '2006-05-31', '1', '2012-11-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('59', '11', '2002-09-28', '5', '2009-08-15', '1', '1984-06-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('60', '5', '2013-03-01', '5', '2014-08-31', '1', '1998-09-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('61', '10', '1971-02-11', '7', '2000-10-15', '1', '1992-09-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('62', '8', '1995-06-30', '4', '1994-08-23', '1', '1982-01-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('63', '11', '2013-10-21', '2', '2004-11-15', '2', '2014-08-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('64', '1', '2004-01-06', '2', '1982-09-19', '2', '1988-04-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('65', '3', '2020-09-11', '6', '2015-09-01', '1', '2020-02-24');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('66', '2', '2012-09-15', '2', '1979-11-14', '1', '2007-01-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('67', '10', '2021-04-30', '2', '2018-03-03', '1', '1982-03-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('68', '10', '2002-08-04', '5', '2011-07-30', '1', '1982-04-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('69', '1', '2005-04-07', '3', '1995-04-08', '3', '1975-06-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('70', '5', '1988-04-03', '1', '1984-05-27', '3', '1972-03-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('71', '8', '1974-03-07', '4', '2013-10-04', '3', '1985-05-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('72', '8', '1991-10-06', '8', '1992-04-16', '3', '1990-08-11');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('73', '10', '1971-09-10', '5', '1979-06-17', '1', '1970-06-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('74', '8', '2015-01-05', '6', '2002-03-03', '1', '1976-07-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('75', '1', '1970-03-24', '3', '2003-09-05', '2', '1983-07-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('76', '10', '2006-07-30', '5', '1987-10-12', '1', '2004-12-05');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('77', '7', '1985-09-05', '6', '1976-09-10', '3', '1982-04-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('78', '10', '1999-06-19', '2', '2013-11-04', '1', '1997-12-15');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('79', '2', '2001-01-07', '3', '2020-03-05', '3', '2009-10-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('80', '6', '2019-06-13', '2', '2020-01-23', '1', '1999-10-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('81', '11', '2007-03-13', '8', '1991-12-22', '1', '2014-07-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('82', '7', '1988-07-20', '7', '1973-01-29', '3', '2007-06-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('83', '11', '2011-07-27', '2', '1999-08-15', '2', '2020-11-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('84', '5', '1970-09-30', '7', '2000-04-26', '2', '1977-07-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('85', '10', '1974-11-05', '5', '2009-10-27', '2', '2002-12-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('86', '4', '1978-04-10', '6', '2013-12-16', '1', '2015-04-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('87', '3', '2006-04-13', '8', '1992-01-20', '2', '1994-11-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('88', '3', '2008-01-13', '5', '2001-07-04', '1', '2014-11-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('89', '1', '1974-09-02', '5', '1982-01-02', '3', '1973-09-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('90', '12', '1994-10-10', '5', '1977-04-28', '1', '1970-01-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('91', '9', '1980-07-27', '6', '1992-02-04', '3', '1981-03-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('92', '8', '2011-03-30', '6', '2009-06-09', '2', '1990-12-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('93', '8', '1979-12-14', '6', '1974-08-19', '1', '1989-06-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('94', '9', '1999-06-22', '7', '1993-02-05', '2', '2014-11-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('95', '10', '1986-04-04', '7', '1988-05-31', '1', '2017-07-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('96', '12', '2014-01-21', '6', '1975-01-25', '1', '2010-07-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('97', '7', '2009-05-18', '7', '2019-12-26', '3', '2000-09-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('98', '2', '2011-04-23', '3', '1993-05-06', '1', '2015-07-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('99', '1', '2005-02-27', '4', '1993-11-29', '1', '2009-06-15');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('100', '10', '2010-12-28', '5', '1977-06-05', '3', '2017-09-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('101', '12', '1976-08-20', '7', '1990-04-02', '2', '1970-01-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('102', '3', '2019-01-11', '8', '2015-12-03', '1', '2011-10-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('103', '6', '1998-09-04', '1', '2005-05-18', '2', '2004-12-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('104', '6', '2007-10-26', '3', '1983-08-27', '1', '1988-06-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('105', '12', '2011-07-24', '6', '1981-06-14', '2', '2000-12-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('106', '4', '1999-01-17', '1', '1993-12-17', '3', '1994-07-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('107', '3', '2016-02-08', '4', '2002-10-24', '1', '1980-03-26');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('108', '8', '2014-11-25', '4', '1987-11-17', '1', '2011-01-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('109', '2', '2009-08-05', '5', '1978-04-05', '2', '1993-08-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('110', '10', '1992-09-10', '7', '2000-12-08', '3', '1990-09-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('111', '1', '1981-06-26', '6', '2010-10-04', '2', '2019-04-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('112', '12', '1982-01-27', '8', '2011-07-25', '2', '1976-08-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('113', '2', '2018-11-09', '1', '1988-08-26', '2', '2016-07-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('114', '5', '2014-08-05', '6', '1980-07-13', '2', '1983-01-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('115', '12', '1977-10-22', '4', '1979-12-01', '2', '1978-02-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('116', '8', '2002-03-23', '8', '1989-09-03', '1', '1991-04-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('117', '1', '2016-06-29', '8', '2018-08-08', '2', '2006-01-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('118', '6', '1974-06-26', '2', '1999-09-12', '1', '1999-06-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('119', '4', '1977-06-24', '8', '1990-11-18', '1', '1983-08-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('120', '11', '1975-11-23', '4', '2003-05-03', '2', '1988-05-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('121', '11', '1972-12-11', '2', '1985-10-07', '2', '1972-07-16');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('122', '4', '1994-10-04', '5', '1988-11-16', '2', '1977-06-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('123', '11', '2016-10-03', '6', '2017-01-19', '1', '2018-01-15');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('124', '1', '1973-11-02', '1', '1988-12-04', '2', '2007-09-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('125', '10', '1985-04-16', '4', '2003-11-26', '1', '1986-08-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('126', '1', '2000-10-19', '8', '1986-08-24', '1', '2007-01-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('127', '5', '2019-07-09', '2', '1992-05-09', '2', '1981-12-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('128', '11', '2007-04-29', '3', '1973-08-30', '2', '1988-08-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('129', '7', '1984-07-31', '3', '2009-02-09', '1', '1994-08-24');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('130', '7', '1990-05-04', '4', '1987-08-01', '3', '1982-11-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('131', '4', '1996-08-16', '5', '1991-04-19', '1', '1998-10-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('132', '5', '1978-05-09', '4', '1990-12-14', '3', '2009-03-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('133', '8', '1996-01-19', '2', '1983-06-25', '2', '1979-03-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('134', '11', '2000-03-13', '1', '1983-12-21', '3', '2009-07-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('135', '8', '2013-10-04', '6', '1977-07-14', '3', '2009-05-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('136', '4', '2021-02-22', '2', '1978-06-10', '2', '1982-05-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('137', '8', '1989-01-03', '2', '1971-07-10', '2', '1982-03-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('138', '7', '1980-10-18', '8', '2012-10-26', '3', '2005-07-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('139', '1', '1978-05-17', '2', '1982-05-12', '3', '1979-10-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('140', '3', '2006-05-25', '2', '1975-11-23', '1', '2018-07-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('141', '5', '2007-07-08', '7', '1990-05-04', '1', '2014-02-24');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('142', '5', '1978-11-22', '5', '1974-08-13', '3', '1981-02-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('143', '1', '2020-02-25', '5', '2020-05-30', '3', '1972-02-11');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('144', '7', '1982-06-22', '3', '2006-10-26', '3', '1990-10-17');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('145', '10', '2017-01-10', '2', '1993-03-30', '1', '2013-11-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('146', '6', '1995-01-30', '3', '2019-08-17', '1', '1988-11-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('147', '5', '1994-10-25', '5', '1981-10-25', '1', '1974-05-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('148', '6', '2003-01-04', '1', '2004-10-21', '2', '1972-08-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('149', '4', '2012-02-14', '5', '1975-09-18', '3', '2012-07-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('150', '3', '2010-04-25', '7', '2003-10-02', '2', '1973-05-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('151', '3', '2007-05-01', '5', '1978-10-22', '1', '1985-01-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('152', '4', '1998-03-22', '6', '1998-05-15', '1', '2000-12-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('153', '12', '1985-05-28', '1', '1997-09-07', '3', '1978-08-10');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('154', '10', '1970-12-24', '1', '1978-11-15', '3', '1982-07-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('155', '4', '2006-06-27', '3', '1970-10-23', '3', '1975-09-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('156', '8', '2016-04-23', '7', '2018-09-05', '2', '2020-01-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('157', '7', '1998-03-31', '1', '2018-06-06', '2', '2018-03-05');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('158', '3', '1985-07-29', '1', '2013-12-04', '3', '2019-04-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('159', '11', '1988-08-29', '1', '1982-02-14', '3', '1996-02-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('160', '10', '1975-08-09', '3', '1986-01-10', '1', '2016-10-14');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('161', '2', '1979-12-24', '6', '1991-01-20', '1', '1992-09-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('162', '5', '1974-12-16', '6', '1993-08-31', '1', '1974-07-26');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('163', '11', '1982-11-15', '4', '2013-10-18', '1', '1976-08-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('164', '2', '1975-04-24', '3', '1991-11-13', '1', '2007-08-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('165', '12', '2016-07-20', '8', '1984-08-16', '1', '2021-03-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('166', '8', '2005-11-07', '7', '2002-04-12', '3', '1984-06-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('167', '6', '2005-09-13', '8', '1987-12-17', '2', '2000-05-12');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('168', '12', '1991-09-30', '5', '1995-07-28', '1', '1972-01-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('169', '3', '1971-08-31', '7', '2014-12-15', '2', '2016-09-18');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('170', '1', '1995-10-15', '2', '2009-11-22', '2', '1980-07-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('171', '6', '1996-10-24', '3', '1997-09-25', '2', '2000-08-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('172', '6', '1992-06-04', '4', '1992-12-08', '3', '2010-08-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('173', '8', '1971-08-22', '4', '2011-09-07', '2', '2007-11-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('174', '9', '1991-08-06', '2', '2005-09-20', '3', '2004-03-23');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('175', '10', '2003-11-07', '6', '1975-09-21', '3', '2013-01-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('176', '6', '1999-03-24', '4', '1996-05-29', '1', '2019-11-27');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('177', '3', '1997-03-18', '2', '1977-10-02', '1', '2016-07-21');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('178', '4', '2003-09-02', '8', '1971-02-05', '3', '2011-02-11');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('179', '3', '1992-08-14', '4', '1973-11-07', '1', '2001-09-04');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('180', '3', '1992-05-22', '7', '2000-08-25', '1', '1977-08-08');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('181', '5', '1988-10-20', '6', '1985-10-24', '1', '2012-01-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('182', '8', '2020-07-08', '2', '1999-03-15', '3', '1992-10-09');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('183', '7', '2020-07-14', '7', '2015-08-20', '3', '1982-08-22');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('184', '11', '2003-07-05', '4', '1991-11-24', '2', '2015-12-31');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('185', '9', '2003-07-03', '8', '2015-08-31', '1', '1971-11-11');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('186', '6', '1982-08-25', '1', '1987-04-05', '3', '1974-06-07');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('187', '1', '2012-07-02', '6', '1973-01-31', '1', '2006-02-03');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('188', '8', '1979-09-18', '4', '1988-10-26', '2', '1989-04-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('189', '10', '1978-09-27', '3', '2000-01-25', '1', '2009-08-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('190', '1', '2000-05-01', '1', '1972-02-23', '3', '1970-01-30');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('191', '1', '2011-03-17', '2', '2004-11-15', '3', '1997-10-13');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('192', '5', '2009-05-15', '5', '1993-12-22', '1', '1996-09-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('193', '2', '1998-11-07', '6', '1990-07-20', '2', '1998-08-01');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('194', '10', '1980-05-22', '7', '1998-06-10', '2', '2020-11-02');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('195', '2', '1978-05-10', '7', '1973-03-19', '1', '1974-07-29');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('196', '12', '1979-06-10', '4', '1980-02-15', '1', '1997-04-06');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('197', '4', '1992-09-20', '5', '2001-05-16', '2', '2004-05-25');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('198', '8', '1992-11-01', '3', '1994-06-09', '3', '1975-05-28');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('199', '3', '2020-07-19', '3', '2012-12-25', '1', '2001-08-19');
INSERT INTO сandidate_status (candidate_id, vacancies_type_id, date_beginning, interview_status_id, stage_date, decision_id, decision_date) VALUES ('200', '5', '1981-08-04', '3', '1998-02-10', '3', '2009-05-05');

-- ИСПРАВИМ СГЕНЕРИРОВАННЫЕ ДАННЫЕ ТАБЛИЦ
-- Исправления будут только у тех данных, которые потребуются для составления запросов.

-- Исправим сгенерированные данные таблицы vacancies. Значения даты закрытия вакансии '0000-00-00' изменим на NULL
UPDATE vacancies 
SET job_closing_date=NULL
WHERE job_closing_date=0000-00-00;

-- Исправим сгенерированные данные таблицы position_of_candidates. 
-- Представим, что генератор указал для всех ЗП в RUB. Скопируем столбец с данными - у нас появится столбец в валюте RUB
ALTER TABLE position_of_candidates
ADD waiting_for_salary_RUB char(10) NOT NULL;

UPDATE position_of_candidates
SET waiting_for_salary_RUB = waiting_for_salary;

-- Поделим на курс соответствующей валюты.
UPDATE position_of_candidates 
SET waiting_for_salary = (waiting_for_salary/73.74)
WHERE currency = 'USD';

UPDATE position_of_candidates 
SET waiting_for_salary = (waiting_for_salary/86.57)
WHERE currency = 'EUR';

-- Выведем данные кандидатов, объединив ФИО и расположив их в алфавитном порядке
SELECT CONCAT(surname, ' ', name, ' ', middle_name) as candidate_name, 
	   telephone, email 
 FROM candidate
 ORDER BY candidate_name;

-- Выведем фамилию, имя и контактный телефон сотрудников Исполнителя и Заказчика
SELECT surname, name, telephone 
 FROM implementer_employee
  UNION 
 SELECT surname, name, telephone  FROM client_employee;

-- Выведем все проекты и компании, к которым проекты относятся. Отсортируем по компании
SELECT client.company_name, projects.project
 FROM projects
  JOIN client ON (client.id = projects.client_id)
 ORDER BY client.company_name;

-- Выведем количество проектов по каждой компании  
SELECT client.company_name AS 'Заказчик', COUNT(project) AS 'Количество проектов'
 FROM projects
  JOIN client ON (client.id = projects.client_id)
 GROUP BY client.company_name;

-- Выведем все проекты и ответственных сотрудников по ним со стороны Исполнителя и со стороны Заказчика
SELECT p.project, 
  CONCAT(ce.surname, ' ', ce.name, ' ', ce.middle_name) AS 'Ответственный от клиента',
  CONCAT(ie.surname, ' ', ie.name, ' ', ie.middle_name) AS 'Ответственный от исполнителя'
 FROM projects p
  JOIN client_employee ce ON (ce.id = p.client_employee_id)
  JOIN implementer_employee ie ON (ie.id = p.implementer_employee_id)
 ORDER BY p.project;

-- Сделаем выборку по приоритету вакансий
SELECT c.company_name  AS 'Заказчик', vt.name AS 'Вакансия', pv.name AS 'Приоритет'
  FROM vacancies v
   JOIN client c ON (v.client_id = c.id)
   JOIN vacancies_type vt ON (v.vacancies_type_id = vt.id)
   JOIN priority_vacancy pv ON (v.priority_vacancy_id = pv.id)
 ORDER BY pv.name;

-- Из прошлой выборки оставим только те вакансии, у которых приоритет '1-й приоритет'
SELECT c.company_name  AS 'Заказчик', vt.name AS 'Вакансия', pv.name AS 'Приоритет'
  FROM vacancies v
   JOIN client c ON (v.client_id = c.id)
   JOIN vacancies_type vt ON (v.vacancies_type_id = vt.id)
   JOIN priority_vacancy pv ON (v.priority_vacancy_id = pv.id) AND pv.name = '1-й приоритет'
 ORDER BY vt.name;

-- Из прошлой выборки оставим только те вакансии, которые открыты
SELECT c.company_name  AS 'Заказчик', vt.name AS 'Вакансия', pv.name AS 'Приоритет'
  FROM vacancies v
   JOIN client c ON (v.client_id = c.id)
   JOIN vacancies_type vt ON (v.vacancies_type_id = vt.id)
   JOIN priority_vacancy pv ON (v.priority_vacancy_id = pv.id) AND pv.name = '1-й приоритет'
  WHERE v.job_closing_date IS NULL
 ORDER BY vt.name;

-- Выведем ФИО кандидатов, должность и желаемую ЗП, отсортировав по должности и возрастанию ЗП
SELECT CONCAT(c.surname, ' ', c.name, ' ', c.middle_name) AS 'Кандидат', vt.name AS 'Вакансия', pc.waiting_for_salary_RUB AS 'Стоимость'
  FROM position_of_candidates pc
   JOIN candidate c ON pc.candidate_id = c.id
   JOIN vacancies_type vt ON pc.vacancies_type_id = vt.id
 ORDER BY vt.name, pc.waiting_for_salary_RUB;

-- Узнаем среднюю цену на специалиста 'Analyst' на рынке  
SELECT vt.name, round(AVG(pc.waiting_for_salary_RUB), 0) AS 'Средняя стоимость сотрудника'
 FROM position_of_candidates pc
  JOIN vacancies_type vt ON pc.vacancies_type_id = vt.id
 WHERE vt.name = 'Analyst';

-- ПРОЦЕДУРЫ

-- Ставим новое обозначение окончания команды (разделитель)
# Посмотрела уроки. Почитала документацию, не менялся у меня разделитель этой компандой с обозначением //. 
#Меняла через настройки. Но чуть позже попробовала поставить ;; и заработало.
DELIMITER ;;

-- Группировка кандидатов по занимаемой должности
DROP PROCEDURE IF EXISTS sp_grouping_candidate_vacancies;

CREATE PROCEDURE sp_grouping_candidate_vacancies(IN candidate_id bigint unsigned) 
BEGIN
	SELECT pc.candidate_id, pc2.candidate_id
    FROM position_of_candidates pc
     JOIN position_of_candidates pc2 ON pc.vacancies_type_id = pc2.vacancies_type_id
    WHERE pc.candidate_id = candidate_id AND pc2.candidate_id != candidate_id; 
END;;

DELIMITER ;

-- Вызываем процедуру для кандидата 1
CALL sp_grouping_candidate_vacancies(1);

DELIMITER ;;

-- Группировка кандидатов по занимаемой должности и полу
DROP PROCEDURE IF EXISTS sp_grouping_candidate_vacancies_gender;

CREATE PROCEDURE sp_grouping_candidate_vacancies_gender(IN candidate_id bigint unsigned) 
BEGIN
	-- Группировка кандидатов по занимаемой должности
	SELECT pc.candidate_id, pc2.candidate_id
    FROM position_of_candidates pc
     JOIN position_of_candidates pc2 ON pc.vacancies_type_id = pc2.vacancies_type_id
    WHERE pc.candidate_id = candidate_id AND pc2.candidate_id != candidate_id;
    -- Группировка кандидатов по полу
    SELECT cd.candidate_id, cd2.candidate_id
    FROM candidate_data cd
     JOIN candidate_data cd2 ON cd.gender = cd2.gender
    WHERE cd.candidate_id = candidate_id AND cd2.candidate_id != candidate_id;
END;;

DELIMITER ;

-- Вызываем процедуру для кандидата 1
CALL sp_grouping_candidate_vacancies_gender(1);

-- Группировка проектов по Заказчику
DROP PROCEDURE IF EXISTS sp_grouping_projects_client;

DELIMITER ;;

CREATE PROCEDURE sp_grouping_projects_client(IN client_id bigint unsigned) 
BEGIN
	SELECT p.id, p2.id
    FROM projects p
     JOIN projects p2 ON p.client_id = p2.client_id
    WHERE p.id = client_id AND p2.id != client_id;
END;;

DELIMITER ;

-- Вызываем процедуру для проекта 1
CALL sp_grouping_projects_client(1);

    
-- ФУНКЦИИ

-- Напишем функцию, которая вычислит процентное соотношение типа вакансии относительно всего кол-ва вакансий.
-- процент = (кол-во вакансий определённого типа)/(кол-во всех вакансий)*100%
DROP FUNCTION IF EXISTS func_vacancies_type_vacancies;

-- Считаем кол-во вакансий определённого типа
SELECT COUNT(vacancies_type_id)
FROM vacancies
WHERE vacancies_type_id = 1; -- Ответ 14

-- Считаем кол-во всех вакансий
SELECT COUNT(id) 
FROM vacancies; -- Ответ 150

-- Создаём функцию:
CREATE FUNCTION func_vacancies_type_vacancies(v_type_id BIGINT UNSIGNED)
RETURNS FLOAT READS SQL DATA
BEGIN
	DECLARE cnt_v_type INT;
	DECLARE cnt_vacancies INT;
	-- Посчитаем кол-во вакансий определённого типа
    SET cnt_v_type = (
     SELECT COUNT(vacancies_type_id)
      FROM vacancies
      WHERE vacancies_type_id = v_type_id 
    );
	-- Посчитаем кол-во всех вакансий другим способом
    SELECT COUNT(id) 
	 INTO cnt_vacancies
	 FROM vacancies;
	-- Сделаем вывод результата даже при отсутсвии вакансий
	IF cnt_v_type = 0
	THEN
		RETURN cnt_v_type;
	ELSE
		RETURN ((cnt_v_type/cnt_vacancies)*100);
	END IF;
END;;


DELIMITER ;

-- Вызовем функцию для вакансии с id = 1 с двумя знаками после ","
SELECT TRUNCATE(func_vacancies_type_vacancies(1),2);


-- ТРАНЗАКЦИИ

-- Добавим нового кандидата через транзакцию
START TRANSACTION;

INSERT INTO candidate (surname, name, middle_name, telephone, email) VALUES ('Болотников', 'Никита', 'Иванович', '70357580607', 'n.s@example.net');

SELECT @last_candidate_id := last_insert_id();

INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES (last_insert_id(), '2001-07-06', 'м', 'Christland', 'да', ' Холост/Не замужем', '5/2');

INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency, waiting_for_salary_RUB) VALUES (last_insert_id(), '1', '3', '1', '290000', 'RUB', '290000');

COMMIT;

-- Добавим нового кандидата через процедуру и транзакцию
DROP PROCEDURE IF EXISTS sp_add_candidate;

DELIMITER //

CREATE PROCEDURE sp_add_candidate()    IN client_id bigint unsigned) 
BEGIN
	DECLARE tran_rollback BOOL DEFAULT 0;

	START TRANSACTION;
	
    INSERT INTO candidate (surname, name, middle_name, telephone, email) VALUES ('Болотников', 'Никита', 'Иванович', '70357580607', 'n.s@example.net');
    
    SELECT @last_candidate_id := last_insert_id();
    INSERT INTO candidate_data (candidate_id, date_of_birth, gender, current_city, ready_to_move, family_status, schedule) VALUES (last_insert_id(), '2001-07-06', 'м', 'Christland', 'да', ' Холост/Не замужем', '5/2');

    INSERT INTO position_of_candidates (candidate_id, vacancies_type_id, work_experience, job_experience, waiting_for_salary, currency, waiting_for_salary_RUB) VALUES (last_insert_id(), '1', '3', '1', '290000', 'RUB', '290000');

END//

DELIMITER ;
