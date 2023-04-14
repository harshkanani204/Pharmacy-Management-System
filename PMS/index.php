
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

             <?php
              // Check if the form has been submitted
              if ($_SERVER["REQUEST_METHOD"] == "POST") {
                // Get the form data
                $username = $_POST["username"];
                $password = $_POST["password"];

                // Validate the form data (you can add more validation as needed)
                if (empty($username) || empty($password)) {
                  // Display an error message
                  echo "Please enter both username and password.";
                } else {
                  // Perform authentication logic here (e.g. checking against a database)
                  // If the authentication is successful, you can redirect to index.php
                  if ($username == "admin" && $password == "password") {
                    header("Location: index.php");
                    exit;
                  } else {
                    // Display an error message for invalid credentials
                    echo "Invalid username or password.";
                  }
                }
              }
              ?>
             <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" method="post" action="index.php">

               <div class="item form-group">
                 <div class="col-md-12 col-sm-12  form-group has-feedback">
                   <input type="text" class="form-control has-feedback-left" name="username" placeholder="Username">
                   <span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
                 </div>
               </div>
               <div class="item form-group">
                 <div class="col-md-12 col-sm-12  form-group has-feedback">
                   <input type="password" class="form-control has-feedback-left" name="password" placeholder="*************">
                   <span class="fa fa-lock form-control-feedback left" aria-hidden="true"></span>
                 </div>
               </div>
               <div class="ln_solid"></div>
               <div class="item form-group">
                 <div class="col-md-12 col-sm-12">
                   <center>
                     <a href="admin" class="btn" style="background-color: rgb(22, 104, 122);color: rgb(192, 202, 211);">Login as Admin</a>
                     <a href="cashier" class="btn" style="background-color: rgb(121,146,168);color: rgb(11, 52, 61);">Login as Cashier</a>
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