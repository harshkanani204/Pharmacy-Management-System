from django.shortcuts import render
from django.db import connection
from django.template import loader
from django.http import HttpResponse
from .models import *
# Create your views here.

def most_regular_customer(request):
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT customer.customerid, customer.firstname||' '||customer.lastname, COUNT(sales.salesid) AS num_purchases
            FROM customer
            JOIN sales ON customer.customerid = sales.customerid
            GROUP BY customer.customerid, customer.firstname||' '||customer.lastname
            ORDER BY num_purchases DESC;
            """,
        )
        rows = cursor.fetchall()
    
    template = loader.get_template('most_regular_customer.html')
    context = {
        'rows': rows,
    }
    return HttpResponse(template.render(context,request))

def most_sold_drugs(request):
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT s.drugid, i.drugname, SUM(s.salesquantity) as total_sales
            FROM sales s
            INNER JOIN drug i ON s.drugid = i.drugid
            GROUP BY s.drugid, i.drugname
            ORDER BY total_sales DESC;
            """,
        )
        rows = cursor.fetchall()
    
    template = loader.get_template('most_sold_drugs.html')
    context = {
        'rows': rows,
    }
    return HttpResponse(template.render(context,request))

def unique_drugs(request):
    with connection.cursor() as cursor:
        cursor.execute(
            """
            SELECT DISTINCT ON (drug.drugid, drug.drugname)
                drug.drugid,
                drug.drugname
            FROM inventory
            INNER JOIN drug ON inventory.drugid = drug.drugid
            WHERE inventory.quantity > 0;
            """,
        )
        rows = cursor.fetchall()
    
    template = loader.get_template('unique_drugs.html')
    context = {
        'rows': rows,
    }
    return HttpResponse(template.render(context,request))

def home(request):
    return render(request, 'home.html')


def views(request):
    return render(request, 'views.html')


def tables(request):
    return render(request, 'tables.html')

def company(request):
    companys = Company.objects.all().values()
    template = loader.get_template('company.html')
    context = {
        'companys': companys,
    }
    return HttpResponse(template.render(context,request))

def customer(request):
    customers = Customer.objects.all().values()
    template = loader.get_template('customer.html')
    context = {
        'customers': customers,
    }
    return HttpResponse(template.render(context,request))

def drug(request):
    drugs = Drug.objects.all().values()
    template = loader.get_template('drug.html')
    context = {
        'drugs': drugs,
    }
    return HttpResponse(template.render(context,request))

def employee(request):
    employees = Employee.objects.all().values()
    template = loader.get_template('employee.html')
    context = {
        'employees': employees,
    }
    return HttpResponse(template.render(context,request))

def inventory(request):
    inventorys = Inventory.objects.all().values()
    template = loader.get_template('inventory.html')
    context = {
        'inventorys': inventorys,
    }
    return HttpResponse(template.render(context,request))

def prescription(request):
    prescriptions = Prescription.objects.all().values()
    template = loader.get_template('prescription.html')
    context = {
        'prescriptions': prescriptions,
    }
    return HttpResponse(template.render(context,request))

def purchase(request):
    purchases = Purchase.objects.all().values()
    template = loader.get_template('purchase.html')
    context = {
        'purchases': purchases,
    }
    return HttpResponse(template.render(context,request))

def sale(request):
    sales = Sales.objects.all().values()
    template = loader.get_template('sale.html')
    context = {
        'sales': sales,
    }
    return HttpResponse(template.render(context,request))

def supplier(request):
    suppliers = Supplier.objects.all().values()
    template = loader.get_template('supplier.html')
    context = {
        'suppliers': suppliers,
    }
    return HttpResponse(template.render(context,request))

