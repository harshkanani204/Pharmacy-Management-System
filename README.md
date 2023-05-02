### **Usage:**

**1. First install the following:**
- Django: `pip install django`
- psycopg: `pip install psycopg`

**2. Then create a database named pharmacy_ms in pgadmin and restore the database from `pharmacy_ms.tar` file located in `pharmacyapp` directory.**

**3. After which go to `pharmacy` directory and open `settings.py` where one need to provide the password for database.**

```python
DATABASES = {
    "default": {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'pharmacy_ms',
        'USER': 'postgres',
        'PASSWORD': '', ##Enter your password here.
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}
```

**4. To see if the database is connected succesfully or not run the following command**
- `python manage.py dbshell` 

- Try to list tables and view the data. If everything seems fine that means it's all correct.

**5. To run the server run the following command.**
- `python manage.py runserver`

- It should look like [this](./Screenshot%20from%202023-05-02%2015-23-41.png).
- Then go to the address in your browser and add `admin\` in the url.
- Now you should be able to see the [Login Window](./login_page2.png)

