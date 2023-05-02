from django.contrib import admin
from .models import Company,Customer,Drug,Drugexpiry,Login,Employee,Inventory,Login, Prescription,Purchase,Sales,Supplier

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

class DrugExpiryAdmin(admin.ModelAdmin):
    list_display = ("drugexpiryid", "drugid", "expirydate")
admin.site.register(Drugexpiry, DrugExpiryAdmin)

class EmployeeAdmin(admin.ModelAdmin):
    list_display = ("employeeid","firstname","lastname","address","phone","email","role")
admin.site.register(Employee,EmployeeAdmin)

class LoginAdmin(admin.ModelAdmin):
    list_display = ("loginid", "userid", "username", "password")
admin.site.register(Login,LoginAdmin)

class PrescriptionAdmin(admin.ModelAdmin):
    list_display = ("prescriptionid", "customerid", "drugid", "prescriptiondate", "prescriptionquantity")
admin.site.register(Prescription, PrescriptionAdmin)

class PurchaseAdmin(admin.ModelAdmin):
    list_display = ("purchaseid","drugid","supplierid","purchasedate","quantity","purchaseprice")
admin.site.register(Purchase,PurchaseAdmin)

class SalesAdmin(admin.ModelAdmin):
    list_display = ("salesid","drugid","salesdate","salesquantity","salesprice")
admin.site.register(Sales,SalesAdmin)

class SupplierAdmin(admin.ModelAdmin):
    list_display = ("supplierid","suppliername","supplieraddress","supplierphone","supplieremail")
admin.site.register(Supplier, SupplierAdmin)

