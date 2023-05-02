<?php
// Your code for fetching data from the database and populating the form with the current values
// ...

// Check if the form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  // Retrieve the form data
  $id = $_POST['id'];
  $newData1 = $_POST['new_data_1'];
  $newData2 = $_POST['new_data_2'];

  // Your code for updating the data in the database with the new values
  // ...

  // Redirect to the view page or any other page after successful update
  header("Location: view.php?id=" . $id);
  exit();
}
?>

<!-- HTML form for editing data -->
<form method="post">
  <input type="hidden" name="id" value="<?php echo $row['ID']; ?>">
  <label for="new_data_1">New Data 1:</label>
  <input type="text" name="new_data_1" id="new_data_1" value="<?php echo $row['data_1']; ?>">
  <label for="new_data_2">New Data 2:</label>
  <input type="text" name="new_data_2" id="new_data_2" value="<?php echo $row['data_2']; ?>">
  <button type="submit">Update</button>
</form>
