create or replace PACKAGE SI_SUBJECTS_PKG IS
-- Работа с субъектами учета
-- %author Кораблев П.А., Захариков В.В.

-- Добавление или изменение записи о субъекте учета.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJ_TYPE_ID          Тип субъекта
-- %param num_N_BASE_SUBJECT_ID       Базовый субъект
-- %param num_N_SUBJ_STATE_ID         Состояние субъекта
-- %param num_N_PARENT_SUBJ_ID        Родительский субъект
-- %param num_N_OWNER_ID              Владелец
-- %param vch_VC_NAME                 Полное наименование
-- %param vch_VC_CODE                 Краткое наименование
-- %param vch_VC_REM                  Комментарий
-- %param num_N_FIRM_ID               Фирма
-- %param num_N_REGION_ID             Регион
-- %param dt_D_ACTUALIZE              Дата актуализации данных по субъекту
-- %param vch_VC_CODE_ADD             Дополнительный код
-- %param num_N_SERVER_ID             Сервер
-- %param num_N_SUBJ_GROUP_ID         Группа субъекта
-- %param tbl_T_TAGS                  Теги
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJECTS_PUT(
  num_N_SUBJECT_ID                    IN OUT SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_TYPE_ID                  IN SI_SUBJECTS.N_SUBJ_TYPE_ID%TYPE,
  num_N_BASE_SUBJECT_ID               IN SI_SUBJECTS.N_BASE_SUBJECT_ID%TYPE := NULL,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE := NULL,
  num_N_PARENT_SUBJ_ID                IN SI_SUBJECTS.N_PARENT_SUBJ_ID%TYPE := NULL,
  num_N_OWNER_ID                      IN SI_SUBJECTS.N_OWNER_ID%TYPE := NULL,
  vch_VC_NAME                         IN SI_SUBJECTS.VC_NAME%TYPE := NULL,
  vch_VC_CODE                         IN SI_SUBJECTS.VC_CODE%TYPE := NULL,
  vch_VC_REM                          IN SI_SUBJECTS.VC_REM%TYPE := NULL,
  num_N_FIRM_ID                       IN SI_SUBJECTS.N_FIRM_ID%TYPE := NULL,
  num_N_REGION_ID                     IN SI_SUBJECTS.N_REGION_ID%TYPE := NULL,
  dt_D_ACTUALIZE                      IN SI_SUBJECTS.D_ACTUALIZE%TYPE := NULL,
  vch_VC_CODE_ADD                     IN SI_SUBJECTS.VC_CODE_ADD%TYPE := NULL,
  num_N_SERVER_ID                     IN NUMBER := NULL,
  num_N_SUBJ_GROUP_ID                 IN SI_SUBJ_GROUPS.N_SUBJ_GROUP_ID%TYPE := NULL,
  tbl_T_TAGS                          IN TAGS := NULL,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL);

-- Изменение состояния субъекта учета.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJ_STATE_ID         Новое состояние
-- %param num_N_REASON_DOC_ID         Документ-основание
-- %param vch_VC_PASSWORD             Пароль для пользователя СУБД
-- %param b_Raise_Errors              Флаг для вызова исключений при возникновении ошибок
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJECTS_CHG_STATE(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE,
  num_N_REASON_DOC_ID                 IN SD_DOCUMENTS.N_DOC_ID%TYPE := NULL, -- док-основание для смены состояния
  vch_VC_PASSWORD                     IN VARCHAR2 := NULL, -- Пароль для пользователя СУБД
  b_Raise_Errors                      IN CONST.BOOL := CONST.b_TRUE,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL);

-- Процедура смены состояния субъекта учета (дублер без перегрузки).
-- %param num_N_SUBJECT_ID            СУ
-- %param num_N_SUBJ_STATE_ID         Новое состояние
-- %param vch_VC_PASSWORD             Пароль пользователя СУБД (только для пользователей СУБД)
PROCEDURE CHANGE_STATE(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE,
  vch_VC_PASSWORD                     IN VARCHAR2 := NULL);

-- Изменить состояние субъекта учета и возвратить результат.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJ_STATE_ID         Новое состояние
-- %param num_N_REASON_DOC_ID         Документ-основание
-- %param vch_VC_PASSWORD             Пароль для пользователя СУБД
-- %param b_Raise_Errors              Флаг для вызова исключений при возникновении ошибок
-- %param num_N_SCN                   Версия
-- %return Признак успешного изменения состояния
FUNCTION SI_SUBJECTS_CHG_STATE(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE,
  num_N_REASON_DOC_ID                 IN SD_DOCUMENTS.N_DOC_ID%TYPE := NULL, -- док-основание для смены состояния
  vch_VC_PASSWORD                     IN VARCHAR2 := NULL, -- Пароль для пользователя СУБД
  b_Raise_Errors                      IN CONST.BOOL := CONST.b_TRUE,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL)
RETURN CONST.BOOL;

-- Актуализовать субъект учета.
-- %param num_N_SUBJECT_ID            Субъект
PROCEDURE SI_SUBJECTS_ACTUALIZE(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE);

-- Удалить запись о субъекте учета.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJECTS_DEL(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL);

-- Update versions of dependent values
-- %param rc_Version                  Version
PROCEDURE UPDATE_DEPENDENCIES(
  rc_Version                          IN OUT SP_VERSIONS%ROWTYPE);

-- Создание или изменение типа дополнительного параметра для субъектов учета.
-- %param num_N_SUBJ_VALUE_TYPE_ID    Тип доп. параметра
-- %param num_N_SUBJ_TYPE_ID          Тип субъекта
-- %param num_N_DATA_TYPE_ID          Тип данных
-- %param vch_VC_CODE                 Краткое наименование
-- %param vch_VC_NAME                 Полное наименование
-- %param num_N_REF_TYPE_ID           Справочник
-- %param ch_C_CAN_MODIFY             Разрешить редактировать параметр
-- %param ch_C_FL_MULTI               Множественный параметр
-- %param ch_C_FL_VALUE_READ_ONLY     Значения параметра только для чтения
-- %param ch_C_FL_VALUE_AUTO_FILL     Автозаполняемый параметр
-- %param num_N_LINE_NO               Номер по порядку
-- %param vch_VC_REM                  Комментарий
-- %param num_N_LANG_ID               Язык
PROCEDURE SI_SUBJ_VALUES_TYPE_PUT(
  num_N_SUBJ_VALUE_TYPE_ID            IN OUT SI_SUBJ_VALUES_TYPE.N_SUBJ_VALUE_TYPE_ID%TYPE,
  num_N_SUBJ_TYPE_ID                  IN SI_SUBJ_VALUES_TYPE.N_SUBJ_TYPE_ID%TYPE,
  num_N_DATA_TYPE_ID                  IN SI_SUBJ_VALUES_TYPE.N_DATA_TYPE_ID%TYPE,
  vch_VC_CODE                         IN SI_SUBJ_VALUES_TYPE.VC_CODE%TYPE,
  vch_VC_NAME                         IN SI_SUBJ_VALUES_TYPE.VC_NAME%TYPE,
  num_N_REF_TYPE_ID                   IN SI_SUBJ_VALUES_TYPE.N_REF_TYPE_ID%TYPE,
  ch_C_CAN_MODIFY                     IN SI_SUBJ_VALUES_TYPE.C_CAN_MODIFY%TYPE,
  ch_C_FL_MULTI                       IN SI_SUBJ_VALUES_TYPE.C_FL_MULTI%TYPE := 'N',
  ch_C_FL_VALUE_READ_ONLY             IN SI_SUBJ_VALUES_TYPE.C_FL_VALUE_READ_ONLY%TYPE := 'N',
  ch_C_FL_VALUE_AUTO_FILL             IN SI_SUBJ_VALUES_TYPE.C_FL_VALUE_AUTO_FILL%TYPE := 'N',
  num_N_LINE_NO                       IN SI_SUBJ_VALUES_TYPE.N_LINE_NO%TYPE := NULL,
  vch_VC_REM                          IN SI_SUBJ_VALUES_TYPE.VC_REM%TYPE := NULL,
  num_N_LANG_ID                       IN SI_SUBJ_VALUES_TYPE.N_LANG_ID%TYPE := SYS_CONTEXT('MAIN', 'N_LANG_ID'));

-- Удалить типа дополнительного параметра для субъектов учета.
-- %param num_N_SUBJ_VALUE_TYPE_ID    Тип доп. параметра
PROCEDURE SI_SUBJ_VALUES_TYPE_DEL(
  num_N_SUBJ_VALUE_TYPE_ID            IN SI_SUBJ_VALUES_TYPE.N_SUBJ_VALUE_TYPE_ID%TYPE);

-- Добавление или изменение записи в L-таблице для настроек дополнительных параметров.
-- %param num_N_SUBJ_VALUE_TYPE_ID    Идентификатор основной таблицы
-- %param num_N_LANG_ID               Язык
-- %param vch_VC_NAME                 Наименование
PROCEDURE LI_SUBJ_VALUES_TYPE_PUT(
  num_N_SUBJ_VALUE_TYPE_ID            IN SI_SUBJ_VALUES_TYPE.N_SUBJ_VALUE_TYPE_ID%TYPE,
  num_N_LANG_ID                       IN SI_SUBJ_VALUES_TYPE.N_LANG_ID%TYPE,
  vch_VC_NAME                         IN SI_SUBJ_VALUES_TYPE.VC_NAME%TYPE);

-- Универсальная процедура для работы с дополнительными параметрами СУ.
-- %param num_N_SUBJ_VALUE_ID         Идентификатор значения доп. параметра
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJ_VALUE_TYPE_ID    Тип дополнительного параметра
-- %param dt_D_VALUE                  Датавременное значение
-- %param ch_C_VALUE                  Символьное значение
-- %param vch_VC_VALUE                Строковое значение
-- %param num_N_VALUE                 Числовое значение
-- %param num_N_REF_ID                Справочное значение
-- %param ch_C_FL_VALUE               Флаговое значение
-- %param clb_CL_VALUE                Текстовое значение
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJ_VALUES_PUT(
  num_N_SUBJ_VALUE_ID                 IN OUT SI_SUBJ_VALUES.N_SUBJ_VALUE_ID%TYPE,
  num_N_SUBJECT_ID                    IN SI_SUBJ_VALUES.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_VALUE_TYPE_ID            IN SI_SUBJ_VALUES.N_SUBJ_VALUE_TYPE_ID%TYPE,
  dt_D_VALUE                          IN SI_SUBJ_VALUES.D_VALUE%TYPE := NULL,
  ch_C_VALUE                          IN SI_SUBJ_VALUES.C_VALUE%TYPE := NULL,
  vch_VC_VALUE                        IN SI_SUBJ_VALUES.VC_VALUE%TYPE := NULL,
  num_N_VALUE                         IN SI_SUBJ_VALUES.N_VALUE%TYPE := NULL,
  ch_C_FL_VALUE                       IN SI_SUBJ_VALUES.C_FL_VALUE%TYPE := NULL,
  num_N_REF_ID                        IN SI_SUBJ_VALUES.N_REF_ID%TYPE := NULL,
  clb_CL_VALUE                        IN SI_SUBJ_VALUES.CL_VALUE%TYPE := NULL,
  num_N_SCN                           IN SI_SUBJ_VALUES.N_SCN%TYPE := NULL);

-- Универсальная процедура для работы с дополнительными параметрами СУ.
-- Внимание: процедура не расчитана на работу со множественными параметрами.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJ_VALUE_TYPE_ID    Тип дополнительного параметра
-- %param dt_D_VALUE                  Датавременное значение
-- %param ch_C_VALUE                  Символьное значение
-- %param vch_VC_VALUE                Строковое значение
-- %param num_N_VALUE                 Числовое значение
-- %param num_N_REF_ID                Справочное значение
-- %param ch_C_FL_VALUE               Флаговое значение
-- %param clb_CL_VALUE                Текстовое значение
-- %param num_N_SCN                   SCN
PROCEDURE PUT_SUBJ_VALUE(
  num_N_SUBJECT_ID                    IN SI_SUBJ_VALUES.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_VALUE_TYPE_ID            IN SI_SUBJ_VALUES.N_SUBJ_VALUE_TYPE_ID%TYPE,
  dt_D_VALUE                          IN SI_SUBJ_VALUES.D_VALUE%TYPE := NULL,
  ch_C_VALUE                          IN SI_SUBJ_VALUES.C_VALUE%TYPE := NULL,
  vch_VC_VALUE                        IN SI_SUBJ_VALUES.VC_VALUE%TYPE := NULL,
  num_N_VALUE                         IN SI_SUBJ_VALUES.N_VALUE%TYPE := NULL,
  ch_C_FL_VALUE                       IN SI_SUBJ_VALUES.C_FL_VALUE%TYPE := NULL,
  num_N_REF_ID                        IN SI_SUBJ_VALUES.N_REF_ID%TYPE := NULL,
  clb_CL_VALUE                        IN SI_SUBJ_VALUES.CL_VALUE%TYPE := NULL,
  num_N_SCN                           IN SI_SUBJ_VALUES.N_SCN%TYPE := NULL);

-- Удаление значения доп. параметра.
-- %param num_N_SUBJ_VALUE_ID         Идентификатор значения доп. параметра
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJ_VALUES_DEL(
  num_N_SUBJ_VALUE_ID                 IN SI_SUBJ_VALUES.N_SUBJ_VALUE_ID%TYPE,
  num_N_SCN                           IN SI_SUBJ_VALUES.N_SCN%TYPE := NULL);

-- Добавить или изменить запись о привязке СУ к СУ (по умолчанию тип привязки — принадлежность к группе).
-- %param num_N_SUBJ_SUBJECT_ID       Привязка
-- %param num_N_SUBJ_BIND_TYPE_ID     Тип привязки
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SUBJECT_BIND_ID       Привязываемый субъект
-- %param num_N_EMP_POSITION_ID       Должность сотрудника для привязки подразделения к роли
-- %param ch_C_FL_MAIN                Признак основной привязки
PROCEDURE SI_SUBJ_SUBJECTS_PUT(
  num_N_SUBJ_SUBJECT_ID               IN OUT SI_SUBJ_SUBJECTS.N_SUBJ_SUBJECT_ID%TYPE,
  num_N_SUBJ_BIND_TYPE_ID             IN SI_SUBJ_SUBJECTS.N_SUBJ_BIND_TYPE_ID%TYPE := NULL,
  num_N_SUBJECT_ID                    IN SI_SUBJ_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJECT_BIND_ID               IN SI_SUBJ_SUBJECTS.N_SUBJECT_BIND_ID%TYPE,
  num_N_EMP_POSITION_ID               IN SI_REF.N_REF_ID%TYPE := NULL,
  ch_C_FL_MAIN                        IN SI_SUBJ_SUBJECTS.C_FL_MAIN%TYPE);

-- Удалить запись о привязке СУ к СУ.
-- %param num_N_SUBJ_SUBJECT_ID       Привязка
PROCEDURE SI_SUBJ_SUBJECTS_DEL(
  num_N_SUBJ_SUBJECT_ID               IN SI_SUBJ_SUBJECTS.N_SUBJ_SUBJECT_ID%TYPE);

-- Универсальная процедура для работы с группами СУ. Внимание: процедура является устаревшей,
-- не использовать.
-- %param num_N_SUBJECT_ID            Идентификатор группы
-- %param num_N_SUBJ_STATE_ID         Состояние
-- %param num_N_OWNER_ID              Владелец
-- %param num_N_FIRM_ID               Фирма (филиал)
-- %param vch_VC_NAME                 Наименование
-- %param vch_VC_CODE                 Код
-- %param vch_VC_REM                  Примечание
-- %param num_N_SUBJ_TYPE_ID          Типы субъектов
PROCEDURE SI_SUBJ_GROUP_PUT(
  num_N_SUBJECT_ID                    IN OUT SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE := NULL,
  num_N_OWNER_ID                      IN SI_SUBJECTS.N_OWNER_ID%TYPE := SYS_CONTEXT('MAIN', 'N_FIRM_ID'),
  num_N_FIRM_ID                       IN SI_SUBJECTS.N_FIRM_ID%TYPE := SYS_CONTEXT('MAIN', 'N_FIRM_ID'),
  vch_VC_NAME                         IN SI_SUBJECTS.VC_NAME%TYPE,
  vch_VC_CODE                         IN SI_SUBJECTS.VC_CODE%TYPE,
  vch_VC_REM                          IN SI_SUBJECTS.VC_REM%TYPE := NULL,
  num_N_SUBJ_TYPE_ID                  IN SI_SUBJ_GROUPS.N_SUBJ_TYPE_ID%TYPE);

-- Добавление или изменение записи о группе субъектов учета.
-- %param num_N_SUBJECT_ID            Идентификатор группы
-- %param num_N_SUBJ_STATE_ID         Состояние
-- %param num_N_GRP_SUBJ_TYPE_ID      Тип субъектов учета, состоящих в группе
-- %param num_N_FIRM_ID               Фирма (филиал)
-- %param vch_VC_NAME                 Наименование
-- %param vch_VC_CODE                 Код
-- %param vch_VC_REM                  Примечание
PROCEDURE SI_SUBJ_GROUPS_PUT(
  num_N_SUBJECT_ID                    IN OUT SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_SUBJ_STATE_ID                 IN SI_SUBJECTS.N_SUBJ_STATE_ID%TYPE := NULL,
  num_N_GRP_SUBJ_TYPE_ID              IN SI_SUBJ_GROUPS.N_SUBJ_TYPE_ID%TYPE,
  num_N_FIRM_ID                       IN SI_SUBJECTS.N_FIRM_ID%TYPE:= SYS_CONTEXT('MAIN', 'N_FIRM_ID'),
  vch_VC_NAME                         IN SI_SUBJECTS.VC_NAME%TYPE,
  vch_VC_CODE                         IN SI_SUBJECTS.VC_CODE%TYPE,
  vch_VC_REM                          IN SI_SUBJECTS.VC_REM%TYPE := NULL);

-- Добавлить/изменить запись о счете СУ.
-- %param num_N_ACCOUNT_ID                    Идентификатор счета
-- %param num_N_SUBJECT_ID                    Идентификатор СУ
-- %param num_N_ACCOUNT_TYPE_ID               Идентификатор типа счета (справочник REF_TYPE_Account_Type)
-- %param num_N_BANK_ID                       Идентификатор банка (оператора связи)
-- %param num_N_CURRENCY_ID                   Идентификатор валюты (справочник REF_TYPE_Currency)
-- %param vch_VC_NAME                         Наименование
-- %param vch_VC_CODE                         Код
-- %param vch_VC_ACCOUNT                      Номер
-- %param dt_D_OPEN                           Дата открытия
-- %param dt_D_CLOSE                          Дата закрытия
-- %param vch_VC_BANK                         Полное наименование банка, в котором открыт счет
-- %param num_N_MAX_OVERDRAFT                 Максимальная сумма кредитного лимита
-- %param vch_VC_REM                          Комментарий
PROCEDURE SI_SUBJ_ACCOUNTS_PUT(
  num_N_ACCOUNT_ID                    IN OUT SI_SUBJ_ACCOUNTS.N_ACCOUNT_ID%TYPE,
  num_N_SUBJECT_ID                    IN SI_SUBJ_ACCOUNTS.N_SUBJECT_ID%TYPE,
  num_N_ACCOUNT_TYPE_ID               IN SI_SUBJ_ACCOUNTS.N_ACCOUNT_TYPE_ID%TYPE,
  num_N_BANK_ID                       IN SI_SUBJ_ACCOUNTS.N_BANK_ID%TYPE := NULL,
  num_N_CURRENCY_ID                   IN SI_SUBJ_ACCOUNTS.N_CURRENCY_ID%TYPE,
  vch_VC_NAME                         IN SI_SUBJ_ACCOUNTS.VC_NAME%TYPE := NULL,
  vch_VC_CODE                         IN SI_SUBJ_ACCOUNTS.VC_CODE%TYPE := NULL,
  vch_VC_ACCOUNT                      IN SI_SUBJ_ACCOUNTS.VC_ACCOUNT%TYPE,
  dt_D_OPEN                           IN SI_SUBJ_ACCOUNTS.D_OPEN%TYPE := NULL,
  dt_D_CLOSE                          IN SI_SUBJ_ACCOUNTS.D_CLOSE%TYPE := NULL,
  vch_VC_BANK                         IN SI_SUBJ_ACCOUNTS.VC_BANK%TYPE := NULL,
  num_N_MAX_OVERDRAFT                 IN SI_SUBJ_ACCOUNTS.N_MAX_OVERDRAFT%TYPE := NULL,
  vch_VC_REM                          IN SI_SUBJ_ACCOUNTS.VC_REM%TYPE := NULL);

-- Удалить запись о счете СУ.
-- %param num_N_ACCOUNT_ID                    Идентификатор счета
PROCEDURE SI_SUBJ_ACCOUNTS_DEL(
  num_N_ACCOUNT_ID                    IN SI_SUBJ_ACCOUNTS.N_ACCOUNT_ID%TYPE);

-- Добавить запись привязки к службам или данные об управлении объектами.
-- %param num_N_SUBJ_SERV_ID          Привязка
-- %param num_N_SUBJ_SERV_TYPE_ID     Тип привязки
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_SERVICE_ID            Служба
-- %param num_N_OBJECT_ID             Компонент службы или отдельный объект учета
-- %param num_N_AUTH_TYPE_ID          Тип авторизаци
-- %param num_N_OBJ_ADDRESS_ID        Интерфейс для усправления
-- %param num_N_PORT_NO               Номер порта для управления
-- %param vch_VC_LOGIN                Логин
-- %param vch_VC_VALUE                Строковый параметр
-- %param num_N_VALUE                 Числовой параметр
-- %param num_N_LOCALE_ID             Локаль
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJ_SERVICES_PUT(
  num_N_SUBJ_SERV_ID                  IN OUT SI_SUBJ_SERVICES.N_SUBJ_SERV_ID%TYPE,
  num_N_SUBJ_SERV_TYPE_ID             IN SI_SUBJ_SERVICES.N_SUBJ_SERV_TYPE_ID%TYPE,
  num_N_SUBJECT_ID                    IN SI_SUBJ_SERVICES.N_SUBJECT_ID%TYPE,
  num_N_SERVICE_ID                    IN SI_SUBJ_SERVICES.N_SERVICE_ID%TYPE,
  num_N_OBJECT_ID                     IN SI_SUBJ_SERVICES.N_OBJECT_ID%TYPE := NULL,
  num_N_AUTH_TYPE_ID                  IN SI_SUBJ_SERVICES.N_AUTH_TYPE_ID%TYPE,
  num_N_OBJ_ADDRESS_ID                IN SI_SUBJ_SERVICES.N_OBJ_ADDRESS_ID%TYPE := NULL,
  num_N_PORT_NO                       IN SI_SUBJ_SERVICES.N_PORT_NO%TYPE := NULL,
  vch_VC_LOGIN                        IN SI_SUBJ_SERVICES.VC_LOGIN%TYPE := NULL,
  vch_VC_VALUE                        IN SI_SUBJ_SERVICES.VC_VALUE%TYPE := NULL,
  num_N_VALUE                         IN SI_SUBJ_SERVICES.N_VALUE%TYPE := NULL,
  num_N_LOCALE_ID                     IN SI_SUBJ_SERVICES.N_LOCALE_ID%TYPE := NULL,
  num_N_SCN                           IN SI_SUBJ_SERVICES.N_SCN%TYPE := NULL);

-- Удалить запись привязки к службам или данные об управлении объектами.
-- %param num_N_SUBJ_SERV_ID          Привязка
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJ_SERVICES_DEL(
  num_N_SUBJ_SERV_ID                  IN SI_SUBJ_SERVICES.N_SUBJ_SERV_ID%TYPE,
  num_N_SCN                           IN SI_SUBJ_SERVICES.N_SCN%TYPE := NULL);

-- Смена пароля для записи о привязке к службе.
-- %param num_N_SUBJ_SERV_ID          Привязка
-- %param vch_VC_OLD_PASS             Старый пароль
-- %param vch_VC_OLD_PASS_HASH        Хэш старого пароля
-- %param vch_VC_NEW_PASS             Новый пароль
-- %param num_N_HASH_TYPE_ID          Тип хэша
-- %param b_NoPassCheck               Флаг для отключения проверки старого пароля
-- %param num_N_SCN                   Версия
PROCEDURE SI_SUBJ_SERVICES_CHG_PASS(
  num_N_SUBJ_SERV_ID                  IN SI_SUBJ_SERVICES.N_SUBJ_SERV_ID%TYPE,
  vch_VC_OLD_PASS                     IN SI_SUBJ_SERVICES.VC_PASS%TYPE := NULL,
  vch_VC_OLD_PASS_HASH                IN SI_SUBJ_SERVICES.VC_HASH_PASS%TYPE := NULL,
  vch_VC_NEW_PASS                     IN SI_SUBJ_SERVICES.VC_PASS%TYPE,
  num_N_HASH_TYPE_ID                  IN SI_SUBJ_SERVICES.N_HASH_TYPE_ID%TYPE := NULL,
  b_NoPassCheck                       IN CONST.BOOL := CONST.b_FALSE,
  num_N_SCN                           IN SI_SUBJ_SERVICES.N_SCN%TYPE := NULL);

-- Проверка пароля.
-- %param num_N_SUBJ_SERV_ID          Идентификатор подписки на службу
-- %param vch_VC_PASS                 Пароль
-- %param vch_VC_HASH_PASS            Хэш пароля
PROCEDURE SI_SUBJ_SERVICES_CHECK_PASS(
  num_N_SUBJ_SERV_ID                  IN SI_SUBJ_SERVICES.N_SUBJ_SERV_ID%TYPE,
  vch_VC_PASS                         IN SI_SUBJ_SERVICES.VC_PASS%TYPE := NULL,
  vch_VC_HASH_PASS                    IN SI_SUBJ_SERVICES.VC_HASH_PASS%TYPE := NULL);

-- Добавить или изменить запись о комментарии к СУ.
-- %param num_N_LINE_ID               Идентификатор записи
-- %param num_N_SUBJECT_ID            Субъект учета
-- %param num_N_COMMENT_TYPE_ID       Тип комментария
-- %param dt_D_OPER                   Дата записи
-- %param dt_D_SIGNAL                 Дата напоминания
-- %param clb_CL_COMMENT              Комментарий
-- %param vch_VC_COMMENT              Комментарий (оставлен для обратной совместимости)
-- %param num_N_AUTHOR_ID             Автор
PROCEDURE SI_SUBJ_COMMENTS_PUT(
  num_N_LINE_ID                       IN OUT SI_SUBJ_COMMENTS.N_LINE_ID%TYPE,
  num_N_SUBJECT_ID                    IN SI_SUBJ_COMMENTS.N_SUBJECT_ID%TYPE,
  num_N_COMMENT_TYPE_ID               IN SI_SUBJ_COMMENTS.N_SUBJ_COMMENT_TYPE_ID%TYPE := CONST.COMMENT_TYPE_Comment,
  dt_D_OPER                           IN SI_SUBJ_COMMENTS.D_OPER%TYPE := SYSDATE,
  dt_D_SIGNAL                         IN SI_SUBJ_COMMENTS.D_SIGNAL%TYPE := NULL,
  clb_CL_COMMENT                      IN SI_SUBJ_COMMENTS.CL_COMMENT%TYPE := NULL,
  vch_VC_COMMENT                      IN VARCHAR2 := NULL,
  num_N_AUTHOR_ID                     IN SI_SUBJ_COMMENTS.N_AUTHOR_ID%TYPE := SYS_CONTEXT('MAIN', 'N_USER_ID'));

-- Установить дату выполнения для комментария к СУ.
-- %param num_N_LINE_ID               Идентификатор записи
-- %param dt_D_EXEC                   Дата выполнения
PROCEDURE SI_SUBJ_COMMENTS_SET_EXEC(
  num_N_LINE_ID                       IN OUT SI_SUBJ_COMMENTS.N_LINE_ID%TYPE,
  dt_D_EXEC                           IN SI_SUBJ_COMMENTS.D_EXEC%TYPE := NULL);

-- Сбросить дату выполнения для комментария к СУ.
-- %param num_N_LINE_ID               Идентификатор записи
PROCEDURE SI_SUBJ_COMMENTS_UNSET_EXEC(
  num_N_LINE_ID                       IN OUT SI_SUBJ_COMMENTS.N_LINE_ID%TYPE);

-- Удалить запись о комментарии к СУ.
-- %param num_N_LINE_ID               Идентификатор записи
PROCEDURE SI_SUBJ_COMMENTS_DEL(
  num_N_LINE_ID                       IN SI_SUBJ_COMMENTS.N_LINE_ID%TYPE);

-- Добавить или изменить запись о привязке файла к субъекту.
-- %param num_N_SUBJ_FILE_ID          Привязка
-- %param num_N_SUBJ_FILE_TYPE_ID     Тип привязки (справочник REF_TYPE_Subj_File_Types)
-- %param num_N_SUBJ_TYPE_ID          Тип субъекта
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_FILE_ID               Файл
-- %param num_N_LINE_NO               Номер по порядку
-- %param num_N_TEMPLATE_LANG_ID      Язык шаблона печатной формы
PROCEDURE SI_SUBJ_FILES_PUT(
  num_N_SUBJ_FILE_ID                  IN OUT SI_SUBJ_FILES.N_SUBJ_FILE_ID%TYPE,
  num_N_SUBJ_FILE_TYPE_ID             IN SI_SUBJ_FILES.N_SUBJ_FILE_TYPE_ID%TYPE := CONST.SUBJ_FILE_TYPE_AnyFile,
  num_N_SUBJ_TYPE_ID                  IN SI_SUBJ_FILES.N_SUBJ_TYPE_ID%TYPE := NULL,
  num_N_SUBJECT_ID                    IN SI_SUBJ_FILES.N_SUBJECT_ID%TYPE := NULL,
  num_N_FILE_ID                       IN SI_SUBJ_FILES.N_FILE_ID%TYPE,
  num_N_LINE_NO                       IN SI_SUBJ_FILES.N_LINE_NO%TYPE := NULL,
  num_N_TEMPLATE_LANG_ID              IN SI_SUBJ_FILES.N_TEMPLATE_LANG_ID%TYPE := NULL);

-- Удалить запись о привязке файла к субъекту.
-- %param num_N_SUBJ_FILE_ID          Привязка
PROCEDURE SI_SUBJ_FILES_DEL(
  num_N_SUBJ_FILE_ID                  IN SI_SUBJ_FILES.N_SUBJ_FILE_ID%TYPE);

-- Изменить привязку к родительскому СУ.
-- %param num_N_SUBJECT_ID            Идентификатор СУ
-- %param num_N_PARENT_SUBJ_ID        Новое значение для идентификатора родительского СУ
PROCEDURE SI_SUBJ_CHG_PARENT_SUBJ_ID(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_PARENT_SUBJ_ID                IN SI_SUBJECTS.N_PARENT_SUBJ_ID%TYPE := NULL);

-- Включить или отключить оборудование абонента и возвратить признак того, что состояние оборудования было изменено.
-- %param num_N_SUBJECT_ID            Идентификатор СУ
-- %param num_N_OBJ_STATE_ID          Состояние ОУ, характеризующее действие:
--                                    {*} OBJ_STATE_Active — включить оборудование
--                                    {*} OBJ_STATE_NotActive — отключить оборудование
-- %param num_N_OBJECT_ID             Оборудование абонента
-- %param b_CloseAddresses            Флаг необходимости закрытия адресов при отключении оборудования
-- %return Признак, что при у оборудования было изменено состояние
FUNCTION SI_SUBJ_DEPEND_OBJ_CHG_STATE(
  num_N_SUBJECT_ID                    SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_OBJ_STATE_ID                  SI_OBJECTS.N_OBJ_STATE_ID%TYPE,
  num_N_OBJECT_ID                     SI_OBJECTS.N_OBJECT_ID%TYPE := NULL,
  b_CloseAddresses                    CONST.BOOL := CONST.b_FALSE)
RETURN CONST.BOOL;

-- Включить или отключить все оборудование абонента.
-- %param num_N_SUBJECT_ID            Идентификатор СУ
-- %param num_N_OBJ_STATE_ID          Состояние ОУ, характеризующее действие:
--                                    {*} OBJ_STATE_Active — включить оборудование
--                                    {*} OBJ_STATE_NotActive — отключить оборудование
-- %param num_N_OBJECT_ID             Оборудование абонента
-- %param b_CloseAddresses            Флаг необходимости закрытия адресов при отключении оборудования
PROCEDURE SI_SUBJ_DEPEND_OBJ_CHG_STATE(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  num_N_OBJ_STATE_ID                  IN SI_OBJECTS.N_OBJ_STATE_ID%TYPE,
  num_N_OBJECT_ID                     IN SI_OBJECTS.N_OBJECT_ID%TYPE := NULL,
  b_CloseAddresses                    IN CONST.BOOL := CONST.b_FALSE);

-- Массовая привязка абонентов к службе.
-- %param num_N_USER_ID               Идентификатор абонента
-- %param num_N_SERVICE_ID            Идентификатор службы
-- %param num_N_SUBJ_SERV_TYPE_ID     Тип привязки к службе
-- %param b_Unsubscribe               Флаг, определяющий, привязывать или отвязывать абонентов
PROCEDURE SI_SUBJ_SERV_CREATE(
  num_N_USER_ID                       IN SI_SUBJECTS.N_SUBJECT_ID%TYPE := NULL,
  num_N_SERVICE_ID                    IN SI_SUBJ_SERVICES.N_SERVICE_ID%TYPE,
  num_N_SUBJ_SERV_TYPE_ID             IN SI_SUBJ_SERVICES.N_SUBJ_SERV_TYPE_ID%TYPE := CONST.SUBJ_SERV_ServiceUse,
  b_Unsubscribe                       IN CONST.BOOL := CONST.b_FALSE);

-- Процедура пересчета «эффективных» логинов по субъекту или объекту.
-- %param num_N_SUBJECT_ID            Субъект
-- %param num_N_OBJECT_ID             Объект
-- %param num_N_SCN                   Версия
PROCEDURE UPDATE_REAL_LOGIN(
  num_N_SUBJECT_ID                    IN SI_SUBJ_SERVICES.N_SUBJECT_ID%TYPE := NULL,
  num_N_OBJECT_ID                     IN SI_SUBJ_SERVICES.N_OBJECT_ID%TYPE := NULL,
  num_N_SCN                           IN SI_SUBJ_SERVICES.N_SCN%TYPE := NULL);

-- Тегирование субъекта учета.
-- %param num_N_SUBJECT_ID            СУ
-- %param tbl_T_TAGS                  Теги
-- %param num_N_SCN                   Версия
PROCEDURE TAG(
  num_N_SUBJECT_ID                    IN SI_SUBJECTS.N_SUBJECT_ID%TYPE,
  tbl_T_TAGS                          IN TAGS,
  num_N_SCN                           IN SI_SUBJECTS.N_SCN%TYPE := NULL);

END SI_SUBJECTS_PKG;