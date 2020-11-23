# Проєктування бази даних

*В рамках проекту розробляється модель бізнес-об'єктів, ER-модель та реляційна схема.*

@startuml

entity Account

entity email

entity password

entity confirmation

entity state

entity inactive

entity active

entity rights

entity nickname

entity verificationRequest

email --* Account

password --* Account

confirmation --* Account

state --* Account

rights --* Account

nickname --* Account

verificationRequest "1,1" -l- "1,1" Account

entity Review

entity Review.creationdate

entity Review.text

entity Review.topic

Review.creationdate -u-* Review

Review.text --* Review

Review.topic -d-* Review

entity User

entity Guest

entity Moderator

entity Admin

entity ReferenceInformation

entity workStatistics

Guest -u-|> User

Moderator -u-|> User

Admin -u-|> User

ReferenceInformation -u- User

workStatistics "1,1" -u- "1,1" Admin : Viewer

inactive --|> state

active --|> state

entity DDF

entity dataset

entity datapoint

entity entity

entity conception
 
 dataset  --* DDF
 
 datapoint  -l-* DDF
 
 entity  -u-* DDF
 
 conception  -d-* DDF

entity Request

entity DeleteRequest

entity CreateRequest

entity ReadRequest

entity UpdateRequest

DeleteRequest --|> Request

CreateRequest --|> Request

ReadRequest -u-|> Request

UpdateRequest -u-|> Request

User "0,*" -u- "1,1" Account : Owner

User "1,1" -r- "0,*" Request

Request "1,1" -r- "0,*" DDF

User "1,1" -l- "0,*" Review : Author

@enduml
