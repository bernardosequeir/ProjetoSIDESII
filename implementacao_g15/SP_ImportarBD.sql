-- DROP TABLE test;
CREATE TEMPORARY TABLE test (
	tableid varchar(20),
    field1 varchar(30),
    field2 varchar(30),
    field3 varchar(30),
    field4 varchar(30),
    field5 varchar(30), 
    field6 varchar(30), 
    field7 varchar(30), 
    field8 varchar(30), 
    field9 varchar(30), 
    field10 varchar(30),
	field11 varchar(30), 
    field12 varchar(30), 
    field13 varchar(30), 
    field14 varchar(30), 
    field15 varchar(30)
);


LOAD DATA INFILE 'C:\\Users\\Bernardo\\Desktop\\teste.csv'
INTO TABLE test
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'
(tableid, field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15);
# INSERE VALORES NA TABELA LOGALERTA
-- SP COMEÇA AQUI 
INSERT INTO logalerta(logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14 from test where tableid="logalerta" ON DUPLICATE KEY UPDATE logalerta.idlogAlerta =logalerta.idlogAlerta;

# INSERA VALORES NA TABELA LOGCARTAO

INSERT INTO logcartao(logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12 from test where tableid="logcartao" ON DUPLICATE KEY UPDATE logcartao.idlogCartao=logcartao.idlogCartao;

INSERT INTO logmedicaosensores(logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11 from test where tableid="logmedicaosensores" ON DUPLICATE KEY UPDATE logmedicaosensores.idLogMedicao=logmedicaosensores.idLogMedicao;

INSERT INTO logronda(logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13 from test where tableid="logronda" ON DUPLICATE KEY UPDATE logronda.idlogRonda=logronda.idlogRonda;

INSERT INTO logrondaextra(logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11 from test where tableid="logrondaextra" ON DUPLICATE KEY UPDATE logrondaextra.idlogRondaExtra=logrondaextra.idlogRondaExtra;

INSERT INTO logsistema(logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15 from test where tableid="logsistema" ON DUPLICATE KEY UPDATE logsistema.idlogSistema=logsistema.idlogSistema;

INSERT INTO logutilizador(logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10 from test where tableid="logutilizador" ON DUPLICATE KEY UPDATE logutilizador.idlogUtilizador=logutilizador.idlogUtilizador;

DROP TABLE test;
