<?php
extract($_POST);


$conn = new mysqli('localhost', 'root', '', 'pms');
// echo "ssds";
if ($conn->connect_error) {
  echo ('connection failed : ' . $conn->connect_error);
} else {
  $stmt = $conn->prepare("insert into supplier (ID, Name, Email, Phone, Address) VALUES (?,?, ?, ?, ?)");

  $stmt->bind_param("issis", $ID, $Name, $Email, $Phone, $Address);
  $stmt->execute();

  $stmt->close();
  $conn->close();
} 
?>

<!DOCTYPE html>
<html lang="en">
<?php include 'include/header.php'; ?>

<body class="nav-md">
  <?php include 'include/sidebar.php'; ?>
  <?php include 'include/menufooter.php'; ?>
  </div>
  </div>

  <?php include 'include/topnav.php'; ?>

  <!-- page content -->
  <div class="right_col" role="main">
    <div class="">
      <div class="page-title">
        <div class="title_left">
          <h3><i class="fa fa-truck"></i> Add Supplier</h3>
        </div>
      </div>

      <div class="clearfix"></div>

      <div class="row">
        <div class="col-md-12 col-sm-12  ">
          <div class="x_panel">
            <div class="x_title">
              <h2>Supplier Information</h2>
              <div class="clearfix"></div>
            </div>
            <div class="x_content">
              <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" method="post">
                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <input type="text" class="form-control has-feedback-left" placeholder="ex. 09809879797" name="ID">
                    <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                  </div>
                </div>
                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <input type="text" class="form-control has-feedback-left" placeholder="Supplier Name" name="Name">
                    <span class="fa fa-truck form-control-feedback left" aria-hidden="true"></span>
                  </div>
                </div>
                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <input type="text" class="form-control has-feedback-left" placeholder="ex. supplier@gmail.com" name="Email">
                    <span class="fa fa-envelope form-control-feedback left" aria-hidden="true"></span>
                  </div>
                </div>
                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <input type="text" class="form-control has-feedback-left" placeholder="ex. 09809879797" name="Phone">
                    <span class="fa fa-phone form-control-feedback left" aria-hidden="true"></span>
                  </div>
                </div>
                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <input type="text" class="form-control has-feedback-left" placeholder="Address" name="Address">
                    <span class="fa fa-map form-control-feedback left" aria-hidden="true"></span>
                  </div>
                </div>

                <div class="item form-group">
                  <div class="col-md-8 col-sm-8 offset-md-2">
                    <button class="btn btn-primary" type="button">Cancel</button>
                    <button type="submit" class="btn btn-success">Submit</button>
                  </div>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
  </div>



  <?php include 'include/footer.php'; ?>
</body>

</html>