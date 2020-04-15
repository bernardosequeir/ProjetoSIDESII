CREATE DEFINER=`root`@`localhost` PROCEDURE `importacao`()
BEGIN
INSERT IGNORE INTO logalerta(logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14 from test where tableid="logalerta"; -- ON DUPLICATE KEY UPDATE logalerta.idlogAlerta =logalerta.idlogAlerta;
INSERT IGNORE INTO logcartao(logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12 from test where tableid="logcartao"; -- ON DUPLICATE KEY UPDATE logcartao.idlogCartao=logcartao.idlogCartao;
INSERT IGNORE INTO logmedicaosensores(logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11 from test where tableid="logmedicaosensores"; --  ON DUPLICATE KEY UPDATE logmedicaosensores.idLogMedicao=logmedicaosensores.idLogMedicao;
INSERT IGNORE INTO logronda(logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado) SELECT field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13 from test where tableid="logronda"; -- ON DUPLICATE KEY UPDATE logronda.idlogRonda=logronda.idlogRonda;
INSERT IGNORE INTO logrondaextra(logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11 from test where tableid="logrondaextra"; --  ON DUPLICATE KEY UPDATE logrondaextra.idlogRondaExtra=logrondaextra.idlogRondaExtra;
INSERT IGNORE INTO logsistema(logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13, field14, field15 from test where tableid="logsistema"; --  ON DUPLICATE KEY UPDATE logsistema.idlogSistema=logsistema.idlogSistema;
INSERT IGNORE INTO logutilizador(logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado) select field1, field2, field3, field4, field5, field6, field7, field8, field9, field10 from test where tableid="logutilizador"; -- ON DUPLICATE KEY UPDATE logutilizador.idlogUtilizador=logutilizador.idlogUtilizador;
END