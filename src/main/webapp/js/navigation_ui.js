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
    
    // hide and show inputs, based on add/remove option
    const inputWrapperRole = document.querySelector("#inputWrapperRole");
    const inputWrapperRFID = document.querySelector("#inputWrapperRFID");
 
    // add new user
    addUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
        inputWrapperRole.style.display = "block";
        inputWrapperRFID.style.display = "block";

        manageUsersModal.setAttribute("data-remove", false);

        addUserBtn.innerHTML = "Add User";
    });

    // try to remove existing user
    const rmvUserBtn = document.querySelector("#svgRemoveSign");

    rmvUserBtn.addEventListener("click", () => {
        
        manageUsersModal.style.display = "block";
        inputWrapperRole.style.display = "none";
        inputWrapperRFID.style.display = "none";
    
        addUserBtn.innerHTML = "Remove User";

        manageUsersModal.setAttribute("data-remove", true);
    });
}

manageUserClose.addEventListener("click", () => {
    
    manageUsersModal.style.display = "none";
    manageUserStatus.style.display = "none";
    document.querySelector("#hManageUser").innerHTML = "Remove User";

});

// Pop-Up Manage Location -----------------------------------------------------------------------

const manageLocationsModal = document.querySelector("#popUpManageLocation");
const manageLocationClose  = document.querySelector("#btnCloseManageLocation");
const manageLocationStatus = document.querySelector("#pManageLocationResponse");

function initializeManageLocations () {
 
    const addLocationBtn = document.querySelector("#svgAddSignLocation");
    
    // hide and show inputs, based on add/remove option
    const inputWrapperRole = document.querySelector("#inputWrapperRole");
    const inputWrapperRFID = document.querySelector("#inputWrapperRFID");
 
    // add new Location
    addLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "block";
        inputWrapperRFID.style.display = "block";

        manageLocationsModal.setAttribute("data-remove", false);

        addLocationBtn.innerHTML = "Add Location";
    });

    // try to remove existing Location
    const rmvLocationBtn = document.querySelector("#svgRemoveSignLocation");

    rmvLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "none";
        inputWrapperRFID.style.display = "none";
    
        addLocationBtn.innerHTML = "Remove Location";

        manageLocationsModal.setAttribute("data-remove", true);
    });
}

manageLocationClose.addEventListener("click", () => {
    
    manageLocationsModal.style.display = "none";
    manageLocationStatus.style.display = "none";
    document.querySelector("#hManageLocation").innerHTML = "Remove Location";

});

// close all pop-ups if Location clicks outside of pop-up ui --------------------------------------

window.onmousedown = (event) => {

    if (event.target === manageUsersModal) {

        manageUsersModal.style.display = "none";
        manageUserStatus.style.display = "none";
    }

    if (event.target === manageLocationsModal) {

        manageLocationsModal.style.display = "none";
        manageLocationStatus.style.display = "none";
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