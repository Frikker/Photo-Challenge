# PhotoChallenge APP

---
This README explains API methods

---

First of all, this app was written on Ruby on rails with PostgreSQL. 
* Ruby version - 2.6.3
* Rails version - 6.0.2.1
---

DB contains all that you need: Users, Posts, Comments and Rating. 
***
User methods apply you to claim all info that you need: first and last name, avatar, token and url
---
* <b>Index</b>   
    * Returns you all of the users. Example : 
        *  [
               {
                   "id": 3,
                   "first_name": "Kirill",
                   "last_name": "Stolpnik",
                   "urls": "",
                   "image": {
                       "url": "",
                       "admin": {
                           "url": ""
                       },
                       "main_page": {
                           "url": ""
                       },
                       "users": {
                           "url": ""
                       }
                   }
               },
               ...
           ]
* <b>Show</b>
  * Returns you info about requested user. Example:
    * {
         "id": 3,
         "first_name": "Kirill",
         "last_name": "Stolpnik",
         "urls": "",
         "image": {
             "url": "",
             "admin": {
                 "url": ""
             },
             "main_page": {
                 "url": ""
             },
             "users": {
                 "url": ""
             }
         }
      }
* <b>Create</b>
  * Creates new user. Answer will have message about succeed or fail.