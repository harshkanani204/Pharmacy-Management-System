from django.contrib import admin
from .models import Company,Customer,Drug,Employee,Inventory,Prescription,Purchase,Sales,Supplier

# Register your models here.
class CompanyAdmin(admin.ModelAdmin):
    list_display = ("companyid", "companyname", "companyaddress", "companyphone", "companyemail")
admin.site.register(Company, CompanyAdmin)

class CustomerAdmin(admin.ModelAdmin):
    list_display = ("customerid", "firstname", "lastname", "address", "phone", "email")
admin.site.register(Customer, CustomerAdmin)

class DrugAdmin(admin.ModelAdmin):
    list_display = ("drugid", "drugname", "drugdescription", "drugcategory", "companyid")
admin.site.register(Drug, DrugAdmin)

class EmployeeAdmin(admin.ModelAdmin):
    list_display = ("employeeid","firstname","lastname","address","phone","email","role")
admin.site.register(Employee,EmployeeAdmin)

class PrescriptionAdmin(admin.ModelAdmin):
    list_display = ("prescriptionid", "customerid", "drugid", "prescriptiondate", "prescriptionquantity")
admin.site.register(Prescription, PrescriptionAdmin)

class PurchaseAdmin(admin.ModelAdmin):
    list_display = ("purchaseid","drugid","supplierid","purchasedate","quantity","purchaseprice","expirydate")
admin.site.register(Purchase,PurchaseAdmin)

class SalesAdmin(admin.ModelAdmin):
    list_display = ("salesid","drugid","purchaseid","salesdate","salesquantity","salesprice","customerid")
admin.site.register(Sales,SalesAdmin)

class SupplierAdmin(admin.ModelAdmin):
    list_display = ("supplierid","suppliername","supplieraddress","supplierphone","supplieremail")
admin.site.register(Supplier, SupplierAdmin)

class InventoryAdmin(admin.ModelAdmin):
    list_display = ("inventoryid","drugid", "supplierid", "purchaseid","batchnumber", "purchasedate", "expirydate", "quantity", "purchaseprice", "sellingprice")
admin.site.register(Inventory, InventoryAdmin)

