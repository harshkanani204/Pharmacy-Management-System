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
    companyname = models.CharField(max_length=255, blank=False, null=False)
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
    firstname = models.CharField(max_length=255, blank=False, null=False)
    lastname = models.CharField(max_length=255, blank=False, null=False)
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
    drugname = models.CharField(max_length=255, blank=False, null=False)
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
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=False, null=False)
    expirydate = models.DateField(blank=False, null=False)

    class Meta:
        # managed = False
        db_table = 'drugexpiry'


class Employee(models.Model):
    employeeid = models.AutoField(primary_key=True)
    firstname = models.CharField(max_length=255, blank=False, null=False)
    lastname = models.CharField(max_length=255, blank=False, null=False)
    address = models.CharField(max_length=255, blank=True, null=True)
    phone = models.CharField(max_length=20, blank=True, null=True)
    email = models.CharField(max_length=255, blank=True, null=True)
    role = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        # managed = False
        db_table = 'employee'


class Inventory(models.Model):
    inventoryid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=False, null=False)
    supplierid = models.ForeignKey('Supplier', models.DO_NOTHING, db_column='supplierid', blank=False, null=False)
    purchaseid = models.ForeignKey('Purchase', models.DO_NOTHING, db_column='purchaseid', blank=False, null=False)
    batchnumber = models.CharField(max_length=255, blank=False, null=False)
    purchasedate = models.DateField(blank=False, null=False)
    expirydate = models.DateField(blank=False, null=False)
    quantity = models.IntegerField(blank=False, null=False)
    purchaseprice = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)
    sellingprice = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    class Meta:
        # managed = False
        db_table = 'inventory'


class Login(models.Model):
    loginid = models.AutoField(primary_key=True)
    userid = models.ForeignKey(Employee, models.DO_NOTHING, db_column='userid', blank=False, null=False)
    username = models.CharField(max_length=255, blank=False, null=False)
    password = models.CharField(max_length=255, blank=False, null=False)

    class Meta:
        # managed = False
        db_table = 'login'


class Prescription(models.Model):
    prescriptionid = models.AutoField(primary_key=True)
    customerid = models.ForeignKey(Customer, models.DO_NOTHING, db_column='customerid', blank=False, null=False)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=False, null=False)
    prescriptiondate = models.DateField(blank=False, null=False)
    prescriptionquantity = models.IntegerField(blank=False, null=False)

    class Meta:
        # managed = False
        db_table = 'prescription'


class Purchase(models.Model):
    purchaseid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=False, null=False)
    supplierid = models.ForeignKey('Supplier', models.DO_NOTHING, db_column='supplierid', blank=False, null=False)
    purchasedate = models.DateField(blank=False, null=False)
    quantity = models.IntegerField(blank=False, null=False)
    purchaseprice = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    def __str__(self):
        return f"{self.purchaseid}"

    class Meta:
        # managed = False
        db_table = 'purchase'


class Sales(models.Model):
    salesid = models.AutoField(primary_key=True)
    drugid = models.ForeignKey(Drug, models.DO_NOTHING, db_column='drugid', blank=False, null=False)
    salesdate = models.DateField(blank=False, null=False)
    salesquantity = models.IntegerField(blank=False, null=False)
    salesprice = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    class Meta:
        # managed = False
        db_table = 'sales'


class Supplier(models.Model):
    supplierid = models.AutoField(primary_key=True)
    suppliername = models.CharField(max_length=255, blank=False, null=False)
    supplieraddress = models.CharField(max_length=255, blank=True, null=True)
    supplierphone = models.CharField(max_length=20, blank=True, null=True)
    supplieremail = models.CharField(max_length=255, blank=True, null=True)

    def __str__(self):
        return f"{self.suppliername}({self.supplierid})"

    class Meta:
        # managed = False
        db_table = 'supplier'
