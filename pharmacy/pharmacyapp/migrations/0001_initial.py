# Generated by Django 4.2 on 2023-05-02 08:59

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Company",
            fields=[
                ("companyid", models.AutoField(primary_key=True, serialize=False)),
                (
                    "companyname",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "companyaddress",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "companyphone",
                    models.CharField(blank=True, max_length=20, null=True),
                ),
                (
                    "companyemail",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
            ],
            options={
                "db_table": "company",
            },
        ),
        migrations.CreateModel(
            name="Customer",
            fields=[
                ("customerid", models.AutoField(primary_key=True, serialize=False)),
                ("firstname", models.CharField(blank=True, max_length=255, null=True)),
                ("lastname", models.CharField(blank=True, max_length=255, null=True)),
                ("address", models.CharField(blank=True, max_length=255, null=True)),
                ("phone", models.CharField(blank=True, max_length=20, null=True)),
                ("email", models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                "db_table": "customer",
            },
        ),
        migrations.CreateModel(
            name="Drug",
            fields=[
                ("drugid", models.AutoField(primary_key=True, serialize=False)),
                ("drugname", models.CharField(blank=True, max_length=255, null=True)),
                (
                    "drugdescription",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "drugcategory",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "companyid",
                    models.ForeignKey(
                        blank=True,
                        db_column="companyid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.company",
                    ),
                ),
            ],
            options={
                "db_table": "drug",
            },
        ),
        migrations.CreateModel(
            name="Employee",
            fields=[
                ("employeeid", models.AutoField(primary_key=True, serialize=False)),
                ("firstname", models.CharField(blank=True, max_length=255, null=True)),
                ("lastname", models.CharField(blank=True, max_length=255, null=True)),
                ("address", models.CharField(blank=True, max_length=255, null=True)),
                ("phone", models.CharField(blank=True, max_length=20, null=True)),
                ("email", models.CharField(blank=True, max_length=255, null=True)),
                ("role", models.CharField(blank=True, max_length=255, null=True)),
            ],
            options={
                "db_table": "employee",
            },
        ),
        migrations.CreateModel(
            name="Supplier",
            fields=[
                ("supplierid", models.AutoField(primary_key=True, serialize=False)),
                (
                    "suppliername",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "supplieraddress",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                (
                    "supplierphone",
                    models.CharField(blank=True, max_length=20, null=True),
                ),
                (
                    "supplieremail",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
            ],
            options={
                "db_table": "supplier",
            },
        ),
        migrations.CreateModel(
            name="Sales",
            fields=[
                ("salesid", models.AutoField(primary_key=True, serialize=False)),
                ("salesdate", models.DateField(blank=True, null=True)),
                ("salesquantity", models.IntegerField(blank=True, null=True)),
                (
                    "salesprice",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=10, null=True
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        blank=True,
                        db_column="drugid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.drug",
                    ),
                ),
            ],
            options={
                "db_table": "sales",
            },
        ),
        migrations.CreateModel(
            name="Purchase",
            fields=[
                ("purchaseid", models.AutoField(primary_key=True, serialize=False)),
                ("purchasedate", models.DateField(blank=True, null=True)),
                ("quantity", models.IntegerField(blank=True, null=True)),
                (
                    "purchaseprice",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=10, null=True
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        blank=True,
                        db_column="drugid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.drug",
                    ),
                ),
                (
                    "supplierid",
                    models.ForeignKey(
                        blank=True,
                        db_column="supplierid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.supplier",
                    ),
                ),
            ],
            options={
                "db_table": "purchase",
            },
        ),
        migrations.CreateModel(
            name="Prescription",
            fields=[
                ("prescriptionid", models.AutoField(primary_key=True, serialize=False)),
                ("prescriptiondate", models.DateField(blank=True, null=True)),
                ("prescriptionquantity", models.IntegerField(blank=True, null=True)),
                (
                    "customerid",
                    models.ForeignKey(
                        blank=True,
                        db_column="customerid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.customer",
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        blank=True,
                        db_column="drugid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.drug",
                    ),
                ),
            ],
            options={
                "db_table": "prescription",
            },
        ),
        migrations.CreateModel(
            name="Login",
            fields=[
                ("loginid", models.AutoField(primary_key=True, serialize=False)),
                ("username", models.CharField(blank=True, max_length=255, null=True)),
                ("password", models.CharField(blank=True, max_length=255, null=True)),
                (
                    "userid",
                    models.ForeignKey(
                        blank=True,
                        db_column="userid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.employee",
                    ),
                ),
            ],
            options={
                "db_table": "login",
            },
        ),
        migrations.CreateModel(
            name="Inventory",
            fields=[
                ("inventoryid", models.AutoField(primary_key=True, serialize=False)),
                (
                    "batchnumber",
                    models.CharField(blank=True, max_length=255, null=True),
                ),
                ("purchasedate", models.DateField(blank=True, null=True)),
                ("expirydate", models.DateField(blank=True, null=True)),
                ("quantity", models.IntegerField(blank=True, null=True)),
                (
                    "purchaseprice",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=10, null=True
                    ),
                ),
                (
                    "sellingprice",
                    models.DecimalField(
                        blank=True, decimal_places=2, max_digits=10, null=True
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        blank=True,
                        db_column="drugid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.drug",
                    ),
                ),
                (
                    "purchaseid",
                    models.ForeignKey(
                        blank=True,
                        db_column="purchaseid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.purchase",
                    ),
                ),
                (
                    "supplierid",
                    models.ForeignKey(
                        blank=True,
                        db_column="supplierid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.supplier",
                    ),
                ),
            ],
            options={
                "db_table": "inventory",
            },
        ),
        migrations.CreateModel(
            name="Drugexpiry",
            fields=[
                ("drugexpiryid", models.AutoField(primary_key=True, serialize=False)),
                ("expirydate", models.DateField(blank=True, null=True)),
                (
                    "drugid",
                    models.ForeignKey(
                        blank=True,
                        db_column="drugid",
                        null=True,
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="pharmacyapp.drug",
                    ),
                ),
            ],
            options={
                "db_table": "drugexpiry",
            },
        ),
    ]
