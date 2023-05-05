from django.urls import path
from . import views
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.home, name='home'),
    path('tables/', views.tables, name='tables'),
    path('tables/company', views.company, name='company'),
    path('tables/customer', views.customer, name='customer'),
    path('tables/drug', views.drug, name='drug'),
    path('tables/employee', views.employee, name='employee'),
    path('tables/inventory', views.inventory, name='inventory'),
    path('tables/prescription', views.prescription, name='prescription'),
    path('tables/purchase', views.purchase, name='purchase'),
    path('tables/sale', views.sale, name='sale'),
    path('tables/supplier', views.supplier, name='supplier'),
    path('views', views.views, name='views'),
    path('views/most_regular_customer/', views.most_regular_customer, name='most_regular_customer'),
    path('views/most_sold_drugs/', views.most_sold_drugs, name='most_sold_drugs'),
    path('views/unique_drugs/', views.unique_drugs, name='unique_drugs'),
    
]