function Confirm() {
    var confirm_value = document.createElement('INPUT');
    confirm_value.type = 'hidden';
    confirm_value.name = 'confirm_value';
    if (confirm("Are you sure you want to delete this User?")) {
        confirm_value.value = 'Yes';
    }
    else {
        confirm_value.value = 'No';
    }
    document.forms[0].appendChild(confirm_value);
}

function confirmDelete() {
    var confirmValue = confirm("Are you sure you want to delete this User?");
    document.getElementById("confirm_value").value = confirmValue ? "Yes" : "No";

}
function confirmDelete() {
    var confirmValue = confirm("Are you sure you want to delete this User?");
    document.getElementById('<%= confirm_value.ClientID %>').value = confirmValue ? "Yes" : "No";
    return confirmValue;
}
function Organization() {
    var confirm_value = document.createElement('INPUT');
    confirm_value.type = 'hidden';
    confirm_value.name = 'confirm_value';
    if (confirm("Are you sure you want to delete this Organization?")) {
        confirm_value.value = 'Yes';
    }
    else {
        confirm_value.value = 'No';
    }
    document.forms[0].appendChild(confirm_value);
}
function Role() {
    var confirm_value = document.createElement('INPUT');
    confirm_value.type = 'hidden';
    confirm_value.name = 'confirm_value';
    if (confirm("Are you sure you want to delete this Role?")) {
        confirm_value.value = 'Yes';
    }
    else {
        confirm_value.value = 'No';
    }
    document.forms[0].appendChild(confirm_value);
}
function Organization() {
    var confirm_value = document.createElement('INPUT');
    confirm_value.type = 'hidden';
    confirm_value.name = 'confirm_value';
    if (confirm("Are you sure you want to delete this Measurement?")) {
        confirm_value.value = 'Yes';
    }
    else {
        confirm_value.value = 'No';
    }
    document.forms[0].appendChild(confirm_value);
}
function Goods() {
    var confirm_value = document.createElement('INPUT');
    confirm_value.type = 'hidden';
    confirm_value.name = 'confirm_value';
    if (confirm("Are you sure you want to delete this Item?")) {
        confirm_value.value = 'Yes';
    }
    else {
        confirm_value.value = 'No';
    }
    document.forms[0].appendChild(confirm_value);
}