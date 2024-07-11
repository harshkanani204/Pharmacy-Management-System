# Generated by Django 4.2 on 2023-05-05 17:02

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
                ("companyname", models.CharField(max_length=255)),
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
                ("firstname", models.CharField(max_length=255)),
                ("lastname", models.CharField(max_length=255)),
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
                ("drugname", models.CharField(max_length=255)),
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
                        to="projectapp.company",
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
                ("firstname", models.CharField(max_length=255)),
                ("lastname", models.CharField(max_length=255)),
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
            name="Purchase",
            fields=[
                ("purchaseid", models.AutoField(primary_key=True, serialize=False)),
                ("purchasedate", models.DateField()),
                ("quantity", models.IntegerField()),
                ("purchaseprice", models.DecimalField(decimal_places=2, max_digits=10)),
                ("expirydate", models.DateField()),
                (
                    "drugid",
                    models.ForeignKey(
                        db_column="drugid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.drug",
                    ),
                ),
            ],
            options={
                "db_table": "purchase",
            },
        ),
        migrations.CreateModel(
            name="Supplier",
            fields=[
                ("supplierid", models.AutoField(primary_key=True, serialize=False)),
                ("suppliername", models.CharField(max_length=255)),
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
                ("salesdate", models.DateField()),
                ("salesquantity", models.IntegerField()),
                ("salesprice", models.DecimalField(decimal_places=2, max_digits=10)),
                (
                    "customerid",
                    models.ForeignKey(
                        db_column="customerid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.customer",
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        db_column="drugid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.drug",
                    ),
                ),
                (
                    "purchaseid",
                    models.ForeignKey(
                        db_column="purchaseid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.purchase",
                    ),
                ),
            ],
            options={
                "db_table": "sales",
            },
        ),
        migrations.AddField(
            model_name="purchase",
            name="supplierid",
            field=models.ForeignKey(
                db_column="supplierid",
                on_delete=django.db.models.deletion.DO_NOTHING,
                to="projectapp.supplier",
            ),
        ),
        migrations.CreateModel(
            name="Prescription",
            fields=[
                ("prescriptionid", models.AutoField(primary_key=True, serialize=False)),
                ("prescriptiondate", models.DateField()),
                ("prescriptionquantity", models.IntegerField()),
                (
                    "customerid",
                    models.ForeignKey(
                        db_column="customerid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.customer",
                    ),
                ),
                (
                    "drugid",
                    models.ForeignKey(
                        db_column="drugid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.drug",
                    ),
                ),
            ],
            options={
                "db_table": "prescription",
            },
        ),
        migrations.CreateModel(
            name="Inventory",
            fields=[
                ("inventoryid", models.AutoField(primary_key=True, serialize=False)),
                ("batchnumber", models.CharField(max_length=255)),
                ("purchasedate", models.DateField()),
                ("expirydate", models.DateField()),
                ("quantity", models.IntegerField()),
                ("purchaseprice", models.DecimalField(decimal_places=2, max_digits=10)),
                ("sellingprice", models.DecimalField(decimal_places=2, max_digits=10)),
                (
                    "drugid",
                    models.ForeignKey(
                        db_column="drugid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.drug",
                    ),
                ),
                (
                    "purchaseid",
                    models.ForeignKey(
                        db_column="purchaseid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.purchase",
                    ),
                ),
                (
                    "supplierid",
                    models.ForeignKey(
                        db_column="supplierid",
                        on_delete=django.db.models.deletion.DO_NOTHING,
                        to="projectapp.supplier",
                    ),
                ),
            ],
            options={
                "db_table": "inventory",
            },
        ),
    ]