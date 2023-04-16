@echo off

REM set JAVA_HOME=C:/PATH/TO_JDK
set MVNW_VERBOSE=false
set MAVEN_BATCH_ECHO=off
set ACTION=%~1
echo ACTION = %ACTION%
set CONTEXT=%~2
echo CONTEXT = %CONTEXT%
set MAVEN_PROFILE=%~3
echo MAVEN_PROFILE = %MAVEN_PROFILE%

IF [%2] EQU [] goto usage
IF [%3] EQU [] goto usage
set CONF_DIR=%~dp0..\conf
CD /d "%~dp0..\.."

Setlocal EnableDelayedExpansion
for /f "tokens=1 skip=1" %%G in (%CONF_DIR%\all_schema.txt) do (
   CALL mvnw.cmd liquibase:%ACTION% ^
       -Dliquibase.username=%%G ^
       -Dliquibase.contexts=%CONTEXT% ^
       -Dliquibase.labels=%%G ^
       -P %MAVEN_PROFILE%.%%G,%MAVEN_PROFILE% || goto :error
)
echo Liquibase '%ACTION%' done successfully !
cd script\bin
exit /b 0

:usage
echo ------------------------------------------------------------------- ^
This script need 3 parameters (action, context, database environment)    ^
------------------------------------------------------------------------ ^
action must be in:^
changelogSync, changelogSyncSQL, changelogSyncToTag, ^
changelogSyncToTagSQL, checks.run, checks.show, clearCheckSums, dbDoc, deactivateChangeLog, ^
diff, dropAll, flow, flow.validate, futureRollbackSQL, generateChangeLog, help, history, listLocks, ^
registerChangeLog, releaseLocks, rollback, rollbackOneChangeSet, rollbackOneChangeSetSQL, ^
rollbackOneUpdate, rollbackOneUpdateSQL, rollbackSQL, status, syncHub, tag, tagExists, ^
unexpectedChangeSets, update, updateSQL, updateTestingRollback, validate ^
context and db environment must be in: ^
(dev, test or prod)

:error
echo *** ERROR during liquibase '%ACTION%' ***
exit /b 1