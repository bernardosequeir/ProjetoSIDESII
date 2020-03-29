DELIMITER //
 

/*
CREATE DEFINER=`root`@`localhost` TRIGGER Inserir_Utilizador 
AFTER INSERT ON utilizador FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNome;
	INSERT INTO logutilizador VALUES ( DEFAULT, new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'INSERT',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Atualizar_Utilizador 
AFTER UPDATE ON utilizador FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNome;
	INSERT INTO logutilizador VALUES ( DEFAULT, new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'UPDATE',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_Utilizador 
AFTER DELETE ON utilizador FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNome;
	INSERT INTO logutilizador VALUES ( DEFAULT, old.EmailUtilizador, old.NomeUtilizador, old.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'DELETE',DEFAULT);
END; 


CREATE DEFINER=`root`@`localhost` TRIGGER Inserir_RondaExtra
AFTER INSERT ON rondaextra FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
	INSERT INTO logrondaextra VALUES ( DEFAULT, new.DataHoraEntrada, new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Atualizar_RondaExtra
AFTER UPDATE ON rondaextra FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
	INSERT INTO logrondaextra VALUES ( DEFAULT, new.DataHoraEntrada, new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_RondaExtra
AFTER DELETE ON rondaextra FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserNome;
	INSERT INTO logrondaextra VALUES ( DEFAULT, old.DataHoraEntrada, old.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT);
END;

 

CREATE DEFINER=`root`@`localhost` TRIGGER Inserir_Cartao
AFTER INSERT ON cartao FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
	INSERT INTO logcartao VALUES ( DEFAULT, new.idCartao, new.Ativo, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Atualizar_Cartao
AFTER UPDATE ON cartao FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
	INSERT INTO logcartao VALUES ( DEFAULT, new.idCartao, new.Ativo, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT);
END;  

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_Cartao
AFTER DELETE ON cartao FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserNome;
	INSERT INTO logcartao VALUES ( DEFAULT, old.idCartao, old.Ativo, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT);
END;

CREATE DEFINER=`root`@`localhost` TRIGGER Inserir_Medicoes
AFTER INSERT ON medicaosensores FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, new.idMedicao, new.TipoSensor, new.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT,new.PossivelAnomalia);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Atualizar_Medicoes
AFTER UPDATE ON medicaosensores FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, new.idMedicao, new.TipoSensor, new.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT,new.PossivelAnomalia);
END;  

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_Medicoes
AFTER DELETE ON medicaosensores FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, old.idMedicao, old.TipoSensor, old.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT,old.PossivelAnomalia);
END;
 

CREATE DEFINER=`root`@`localhost` TRIGGER Inserir_Sistema
AFTER INSERT ON sistema FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logsistema VALUES ( DEFAULT, new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END; 

CREATE DEFINER=`root`@`localhost` TRIGGER Atualizar_Sistema
AFTER UPDATE ON sistema FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logsistema VALUES ( DEFAULT, new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END;  

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_Sistema
AFTER DELETE ON sistema FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	INSERT INTO logsistema VALUES ( DEFAULT, old.IDSistema, old.LimiteTemperatura, old.LimiteHumidade, old.LimiteLuminosidade, old.LimiarTemperatura, old.LimiarHumidade, old.LimiarLuminosidade, old.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END;
 
CREATE  DEFINER=`root`@`localhost` TRIGGER Inserir_Alerta
AFTER INSERT ON alerta FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from museu.medicaosensores where new.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, new.idalerta, new.TipoAlerta, new.DataHoraAlerta, new.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END; 

CREATE  DEFINER=`root`@`localhost` TRIGGER Atualizar_Alerta
AFTER UPDATE ON alerta FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from museu.medicaosensores where new.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, new.idalerta, new.TipoAlerta, new.DataHoraAlerta, new.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END;  

CREATE DEFINER=`root`@`localhost` TRIGGER Eliminar_Alerta
AFTER DELETE ON alerta FOR EACH ROW
BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from museu.utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from museu.medicaosensores where old.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, old.idalerta, old.TipoAlerta, old.DataHoraAlerta, old.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END;*/
 
 
 //
DELIMITER ;

