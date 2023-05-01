from django.contrib import admin
from .models import Company,Customer,Drug,Drugexpiry,Employee,Inventory,Login,Prescription,Purchase,Sales,Supplier

# Register your models here.
class CompanyAdmin(admin.ModelAdmin):
    list_display = [f.name for f in Company._meta.get_fields()]

admin.site.register(Company, CompanyAdmin)