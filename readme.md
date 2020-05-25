Примеры кода для выполнения команд из системы уведомлений https://github.com/yankovskiy/notification-system

### Примеры кода в комплекте
1. [PowerShell](https://github.com/yankovskiy/notification-system-remote-samples/blob/master/powershell.ps1 "PowerShell")

### Примечание
Далее в тексте:
- **jobsUrl** http://ns-server:port/jobs
- **completeUrl** http://ns-server:port/complete

### Описание запросов
По GET-запросу на **jobsUrl** возвращается JSON вида:
```json
{
  "ok": true,
  "jobs": [
    {
      "_id": "5ec21e2a3094174c8a92c306",
      "data": {
        "command": "remove",
        "host": "server",
        "target": "logs"
      }
    },
    {
      "_id": "5ec21e2a3094174c8a92c309",
      "data": {
        "command": "remove",
        "host": "server2",
        "target": "logs"
      }
    },
    {
      "_id": "5ec21e433094174c8a92c30d",
      "data": {
        "command": "poweroff",
        "host": "server",
        "target": "os"
      }
    }
  ]
}
```

Массив **jobs** в случае отсутствия задач на исполнение может быть пуст, в данном случае возврат будет:
```json
{
  "ok": true,
  "jobs": []
}
```

В случае ошибки, возвращается JSON вида:
```json
{
  "ok": false,
  "message": "Описание ошибки"
}
```

Каждый элемент массива **jobs** представляет собой задачу для исполнения
```json
    {
      "_id": "5ec21e2a3094174c8a92c306",  
      "data": {                                                  
        "command": "remove",                         
        "host": "server",                                    
        "target": "logs"                                      
      }
    }
``` 

Описание элементов задания:
- **_id** - идентификатор задачи;
- **data** - объект содержащие данные задачи;
- **command** - команда;
- **host** - имя хоста, где нужно выполнить задачу;
- **target** - цель выполнения команды.

Идентификатор задачи должен быть отправлен на **completeUrl** через POST-запрос. В теле запроса должен быть JSON:
```json
{"_id": "5ec21e2a3094174c8a92c306"}
```

Если задача успешно отмечена как выполненная, то ответ будет JSON:
```json
{"ok": true}
```

В противном случае:
```json
{
  "ok": false,
  "message": "Описание ошибки"
}
```
