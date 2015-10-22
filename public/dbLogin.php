
<?php
header('Content-type: application/json');
if($_POST) {
    if($_POST['username'] == 'pam' && $_POST['password'] == 'jaworski') {
    echo '{"success":1}';
 } else {
    echo '{"success":0,"error_message":"Username and/or password is invalid."}';
}
}else {    echo '{"success":0,"error_message":"Username and/or password is invalid."}';}
?>
