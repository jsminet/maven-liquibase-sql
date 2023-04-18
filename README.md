
# <p align="left">Maven liquibase project using pure SQL files on postgresql database</p>
  
    
## 🧐 Features    
- Using one SQL files for update AND rollback
- All password are encrypted using maven encryption capability and store outside the source versioning
- Multi schema management
- Windows shell script for launching liquibase actions on specific DB you passed in parameters looping on all schema we specify in **script\conf\all_schema.txt** file
- Docker compose file for multi DB environment simulation (dev, test, prod)
        
## 🛠️ Tech Stack
- [Postgres SQL](https://www.postgresql.org)
- [Liquibase](https://www.liquibase.org/)
- [Maven](https://maven.apache.org/)
- [Maven extension for encryption](https://github.com/shyiko/servers-maven-extension)
    
## 🛠️ Install Dependencies    
```bash
mvnw clean install
```
        
## 🧑🏻‍💻 Usage
### Docker
```bash
$ docker compose -f "docker\docker-compose.yml" up -d --build
```
Then open http://localhost:8080 in a browser for Adminer, the **docker\schema\init-user-db.sh** script was creating three databases (dev, test, prod) with 2 schemas in each environment (schema1, schema2)

### Maven encryption

Encrypt the master password
```bash
mvnw --emp
Master password: admin
{WhccS9SehqsHpkqkGA/Kl/KPyPdkWJYoefQR4MH5aPA=}
```
Paste it into *%USERPROFILE%\.m2\settings-security.xml* 

```xml
<settingsSecurity>
  <master>{WhccS9SehqsHpkqkGA/Kl/KPyPdkWJYoefQR4MH5aPA=}</master>
</settingsSecurity>
```
Encrypt all the password for every environment and/or schema
```bash
mvnw --ep
Password: schema1
{P2KqUTJBnCQHi3WPUqKA3OPxwr9F6dWwLyhSta9BS5A=}
```
Paste it into **%USERPROFILE%\.m2\settings.xml* (same way for schema2)

```xml
  <servers>
	  <server>
        <id>dev.schema1</id>
        <password>{P2KqUTJBnCQHi3WPUqKA3OPxwr9F6dWwLyhSta9BS5A=}</password>
    </server>
	  <server>
        <id>dev.schema2</id>
        <password>{5dlX23v5W2AH+2oXNpupBPdEJL56fJ39wo/n4plbgzI=}</password>
    </server>
    ...
  </servers>

```
**WARNING** Use a prefix for the id tag name, example: *dev.schema1* , *test.schema2* , ...

### Liquibase
Check **script\bin** directory for all cmd windows shell script.

*TODO* The action list is not complete, add additional scripts for each actions

|script|Usage|
|-|-|
|script\bin\liquibase-dropAll.cmd|Drop all database objects|
|script\bin\liquibase-status.cmd| Get the status of the database versus SQL files|
|cript\bin\liquibase-update.cmd|Launch and validate the update (moving forward)|
|cript\bin\liquibase-rollback.cmd|Launch a rollback (moving backward)|
|...|...|

For rollback, the parameter (rollbackCount) can be change in **.mvn\maven.config** file

These scripts call **script\bin\liquibase-generic.cmd** with two parameters -> a *context* and a *maven profile*

```bash
Example
-------
$ script\bin\liquibase-status.cmd dev dev

ACTION = status
CONTEXT = dev
MAVEN_PROFILE = dev
...

Launch the status action filtering SQL files with dev context tag on all schemas that are part of dev environment
```
        
## 🙇 Useful links
- [Liquibase getting started](https://docs.liquibase.com/start/get-started/liquibase-sql.html)    
- [Liquibase best practices](https://docs.liquibase.com/concepts/bestpractices.html)
- [All liquibase maven goal](https://docs.liquibase.com/tools-integrations/maven/commands/home.html)

        
## 🍰 Contributing    
Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Before contributing, please read the [code of conduct](CODE_OF_CONDUCT.md) & [contributing guidelines](CONTRIBUTING.md).
        
## ❤️ Support  
A simple star to this project repo is enough to keep me motivated on this project for days. If you find your self very much excited with this project let me know with a tweet.
        
## 🙇 Author
#### JS
- Github: [@jsminet](https://github.com/jsminet)
        
## ➤ License
Distributed under the MIT License. See [LICENSE](LICENSE) for more information.
        