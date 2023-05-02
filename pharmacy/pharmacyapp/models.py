# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Company(models.Model):
    companyid = models.AutoField(primary_key=True)
    companyname = models.CharField(max_length=255, blank=True, null=True)
    companyaddress = models.CharField(max_length=255, blank=True, null=True)
    companyphone = models.CharField(max_length=20, blank=True, null=True)
    companyemail = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.companyname}({self.companyid})"

    class Meta:
        # managed = False
        db_table = 'company'


class Customer(models.Model):
    customerid = models.AutoField(primary_key=True)
    firstname = models.CharField(max_length=255, blank=True, null=True)
    lastname = models.CharField(max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.firstname} {self.lastname}({self.customerid})"

    class Meta:
        # managed = False
        db_table = 'customer'


class Drug(models.Model):
    drugid = models.AutoField(primary_key=True)
    drugname = models.CharField(max_length=255, blank=True, null=True)
    drugdescription = models.CharField(max_length=255, blank=True, null=True)
    drugcategory = models.CharField(max_length=255, blank=True, null=True)
    companyid = models.ForeignKey(Company, models.DO_NOTHING, db_column='companyid', blank=True, null=True)

    def __str__(self):
        return f"{self.drugname}({self.drugid})"
    
    class Meta:
        # managed = False
        db_table = 'drug'


class Drugexpiry(models.Model):
    drugexpiryid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=True, null=True)
    expirydate = models.DateField(blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'drugexpiry'


class Employee(models.Model):
    employeeid = models.AutoField(primary_key=True)
    firstname = models.CharField(max_length=255, blank=True, null=True)
    lastname = models.CharField(max_length=255, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    role = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'employee'


class Inventory(models.Model):
    inventoryid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=True, null=True)
    supplierid = models.ForeignKey('Supplier', models.DO_NOTHING, db_column='supplierid', blank=True, null=True)
    purchaseid = models.ForeignKey('Purchase', models.DO_NOTHING, db_column='purchaseid', blank=True, null=True)
    batchnumber = models.CharField(max_length=255, blank=True, null=True)
    purchasedate = models.DateField(blank=True, null=True)
    expirydate = models.DateField(blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    purchaseprice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    sellingprice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'inventory'


class Login(models.Model):
    loginid = models.AutoField(primary_key=True)
    userid = models.ForeignKey(Employee, models.DO_NOTHING, db_column='userid', blank=True, null=True)
    username = models.CharField(max_length=255, blank=True, null=True)
    password = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'login'


class Prescription(models.Model):
    prescriptionid = models.AutoField(primary_key=True)
    customerid = models.ForeignKey(Customer, models.DO_NOTHING, db_column='customerid', blank=True, null=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=True, null=True)
    prescriptiondate = models.DateField(blank=True, null=True)
    prescriptionquantity = models.IntegerField(blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'prescription'


class Purchase(models.Model):
    purchaseid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=True, null=True)
    supplierid = models.ForeignKey('Supplier', models.DO_NOTHING, db_column='supplierid', blank=True, null=True)
    purchasedate = models.DateField(blank=True, null=True)
    quantity = models.IntegerField(blank=True, null=True)
    purchaseprice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    def __str__(self):
        return f"{self.purchaseid}"

    class Meta:
        # managed = False
        db_table = 'purchase'


class Sales(models.Model):
    salesid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=True, null=True)
    salesdate = models.DateField(blank=True, null=True)
    salesquantity = models.IntegerField(blank=True, null=True)
    salesprice = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'sales'


class Supplier(models.Model):
    supplierid = models.AutoField(primary_key=True)
    suppliername = models.CharField(max_length=255, blank=True, null=True)
    supplieraddress = models.CharField(max_length=255, blank=True, null=True)
    supplierphone = models.CharField(max_length=20, blank=True, null=True)
    supplieremail = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.suppliername}({self.supplierid})"

    class Meta:
        # managed = False
        db_table = 'supplier'
