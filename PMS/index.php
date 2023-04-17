<?php
// Start session
session_start();

// Check if the form has been submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
  // Get the form data
  $username = $_POST["username"];
  $password = $_POST["password"];
  $role = $_POST["role"]; // Added role field for differentiating between admin and cashier

  // Validate the form data (you can add more validation as needed)
  if (empty($username) || empty($password) || empty($role)) {
    // Display an error message
    // echo "Please enter both username, password, and select a role.";
  } else {
    // Perform authentication logic here (e.g. checking against a database)
    // You can replace this with your own authentication logic
    $validAdminUsername = "admin";
    $validAdminPassword = "admin";
    $validCashierUsername = "cashier";
    $validCashierPassword = "cashier";

    if ($role == "admin" && $username == $validAdminUsername && $password == $validAdminPassword) {
      // Authentication successful for admin, store username in session and redirect to admin.php
      $_SESSION["username"] = $username;
      header("Location: \PMS\admin\index.php");
      exit;
    } elseif ($role == "cashier" && $username == $validCashierUsername && $password == $validCashierPassword) {
      // Authentication successful for cashier, store username in session and redirect to cashier.php
      $_SESSION["username"] = $username;
      header("Location: \PMS\cashier\index.php");
      exit;
    } else {
      // Display an error message for invalid credentials
      echo "Invalid username, password, or role.";
    }
  }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>Pharmacy Management System </title>

  <!-- Bootstrap -->
  <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- NProgress -->
  <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
  <!-- Animate.css -->
  <link href="vendors/animate.css/animate.min.css" rel="stylesheet">

  <!-- Custom Theme Style -->
  <link href="build/css/custom.min.css" rel="stylesheet">
</head>

<body class="login">
  <div class="login_wrapper">
    <div class="row">
      <div class="col-md-12 col-sm-12  ">
        <div class="x_panel">
          <div class="x_title">
            <center><img src="build/images/logo.png" alt="..." width="200"></center>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" method="post">

              <div class="item form-group">
                <div class="col-md-12 col-sm-12  form-group has-feedback">
                  <input type="text" class="form-control has-feedback-left" name="username" placeholder="Username" id="username">
                  <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                </div>
              </div>
              <div class="item form-group">
                <div class="col-md-12 col-sm-12  form-group has-feedback">
                  <!-- <label for="password">password:</label> -->
                  <input type="password" class="form-control has-feedback-left" name="password" placeholder="*******" id="password">
                  <span class="fa fa-lock form-control-feedback left" aria-hidden="true"></span>
                </div>
              </div>
              <div class="ln_solid"></div>
              <div class="item form-group">
                <div class="col-md-12 col-sm-12">
                  <center>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="role" id="role" value="admin">
                      <label class="form-check-label" for="admin">
                        Admin
                      </label>
                    </div>
                    <div class="form-check form-check-inline">
                      <input class="form-check-input" type="radio" name="role" id="role" value="cashier">
                      <label class="form-check-label" for="flexRadioDefault2">
                        Cashier
                      </label>
                    </div>
                    </center>
                    <center>
                    <input class="btn" value="login " type="submit" style="background-color: rgb(22, 104, 122);color: rgb(192, 202, 211); margin-top:5px;">

                    <!-- <select name="role" id="role" style="background-color: rgb(22, 104, 122);color: rgb(192, 202, 211); padding: 10px 12px; border-radius: 3px; margin:0px 5px 5px 0px;">
                      <option value="admin">Admin</option>
                      <option value="cashier">Cashier</option>
                    </select> -->
                  </center>
                </div>
              </div>

            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>