// Sidebar Collapse (Visual) -----------------------------------------------------------------

const objSidebarNavButton = document.querySelector(".cSidebarNavArrow");
const objSidebar          = document.querySelector(".cSidebar");

objSidebarNavButton.addEventListener("click", () => {
    
    objSidebar.classList.toggle("cSidebarClosed");

});

// Sidebar Item Select (Visual) ---------------------------------------------------------------

const objSidebarItems = document.querySelectorAll(".ulSidebarItem");

objSidebarItems.forEach((obj) => obj.addEventListener("click", updateSidebarSelectionVisuals));

function updateSidebarSelectionVisuals () {

    objSidebarItems.forEach((obj) => obj.classList.remove("ulSidebarItemActive"));

    this.classList.add("ulSidebarItemActive");
}

// Pop-Up Manage Users ------------------------------------------------------------------------

const manageUsersModal = document.querySelector("#popUpManageUser");
const manageUserClose  = document.querySelector("#btnCloseManageUser");
const manageUserStatus = document.querySelector("#pManageUserResponse");

function initializeManageUsers () {
 
    const addUserBtn = document.querySelector("#svgAddSign");
 
    // add new user
    addUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
    });

    // try to remove existing user
    const rmvUserBtn = document.querySelector("#svgRemoveSign");

    rmvUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
    
        document.querySelector("#hManageUser").innerHTML = "Add User";
    });
}

manageUserClose.addEventListener("click", () => {
    
    manageUsersModal.style.display = "none";
    manageUserStatus.style.display = "none";
    document.querySelector("#hManageUser").innerHTML = "Remove User";

});

// close all pop-ups if user clicks outside of pop-up ui --------------------------------------

window.onmousedown = (event) => {

    if (event.target === manageUsersModal) {

        manageUsersModal.style.display = "none";
        manageUserStatus.style.display = "none";
    }
}

// Color Change for input on edit -------------------------------------------------------------

const keyColors = {
    
    colorPrimary: "#e9676e",
    colorTextPrimary: "#0a0c16",
    colorTextSecondary: "##11abd6"
}

function pInputOnFocus(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorPrimary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorPrimary;
    document.getElementById(imTargetLine).style.transform = "scaleX(1)";

}

function pInputOnBlur(imTargetID, imTargetLabel, imTargetLine) {

    document.getElementById(imTargetID).style.color       = keyColors.colorTextPrimary;
    document.getElementById(imTargetLabel).style.color    = keyColors.colorTextSecondary;
    document.getElementById(imTargetLine).style.transform = "scaleX(0)";
    
}