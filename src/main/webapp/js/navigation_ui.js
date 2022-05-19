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

// Pop-Up Manage Users: Add User ---------------------------------------------------------------

const addUsersModal = document.querySelector("#popUpAddUser");
const addUserClose  = document.querySelector("#btnCloseAddUser");
const addUserStatus = document.querySelector("#pAddUserResponse");

function initializeAddUsers () {
 
    const addUserBtn = document.querySelector("#svgAddSign");
     
    addUserBtn.addEventListener("click", () => {
        addUsersModal.style.display = "block";
    });
}

addUserClose.addEventListener("click", () => {
    addUsersModal.style.display = "none";
});

// Pop-Up Manage Users: Remove User -----------------------------------------------------------

const removeUsersModal = document.querySelector("#popUpRemoveUser");
const removeUserClose  = document.querySelector("#btnCloseRemoveUser");
const removeUserStatus = document.querySelector("#pRemoveUserResponse");

function initializeRemoveUsers () {
 
    const removeUserBtn = document.querySelector("#svgRemoveSign");
     
    removeUserBtn.addEventListener("click", () => {
        removeUsersModal.style.display = "block";
    });

    buildDropdown("#cDropdownRemUser");
}

removeUserClose.addEventListener("click", () => {
    removeUsersModal.style.display = "none";
});

// Build dropdown - prev items are removed in ajax control -----------------------------------

function buildDropdown(imTargetDropDownID) {

    const dropDownContainer = document.querySelector(imTargetDropDownID);
    const firstDropDownItem = dropDownContainer.querySelector(".pDropdownFirst");
    const dropDownContent   = dropDownContainer.querySelector(".cDropdownContent");

    // get existing data rows
    const dataRows = document.querySelectorAll("tr");

    // exclude header from data table
    if (dataRows.length <= 1) { return }

    for (let i = 1; i < dataRows.length; i++) {
        
        const dataObj = dataRows[i];
        const dataID  = dataObj.getAttribute("data-valueID");
        const label   = dataObj.getAttribute("data-name");
        
        // first element
        if (i === 1) {
            firstDropDownItem.innerHTML = label + " (" + dataID + ")";
            firstDropDownItem.setAttribute("data-id") = dataID;
        }
        
        // insert dropdown item
        const newHTMLObj = document.createElement("p")

        newHTMLObj.innerHTML = label + " (" + dataID + ")";
        newHTMLObj.classList.add("dropdownItem");
        newHTMLObj.setAttribute("data-id") = dataID;

        dropDownContent.appendChild(newHTMLObj);

        // dropdown click functionality
        newHTMLObj.addEventListener("click", () => {

            firstDropDownItem.innerHTML = newHTMLObj.innerHTML;
            firstDropDownItem.setAttribute("data-id") = newHTMLObj.getAttribute("data-id");
        });
    }
}

// Pop-Up Manage Location: -----------------------------------------------------------------------

const manageLocationsModal = document.querySelector("#popUpManageLocation");
const manageLocationClose  = document.querySelector("#btnCloseManageLocation");
const manageLocationStatus = document.querySelector("#pManageLocationResponse");

function initializeManageLocations () {
 
    const addLocationBtn = document.querySelector("#svgAddSignLocation");
    
    // hide and show inputs, based on add/remove option
    const inputWrapperRole = document.querySelector("#inputWrapperRole");
    const inputWrapperRFID = document.querySelector("#inputWrapperRFID");
    const submitButton     = document.querySelector("#button_manage_location");
    // add new Location
    addLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "block";
        inputWrapperRFID.style.display = "block";

        manageLocationsModal.setAttribute("data-remove", false);

        submitButton.value = "Add Location";
    });

    // try to remove existing Location
    const rmvLocationBtn = document.querySelector("#svgRemoveSignLocation");

    rmvLocationBtn.addEventListener("click", () => {
        
        manageLocationsModal.style.display = "block";
        inputWrapperRole.style.display = "none";
        inputWrapperRFID.style.display = "none";
    
        submitButton.value = "Remove Location";

        manageLocationsModal.setAttribute("data-remove", true);
    });
}

manageLocationClose.addEventListener("click", () => {
    
    manageLocationsModal.style.display = "none";
    manageLocationStatus.style.display = "none";
    document.querySelector("#hManageLocation").innerHTML = "Remove Location";

});

// Pop-Up Manage Authorizations ----------------------------------------------------------------

const manageAuthsModal = document.querySelector("#popUpManageAuthorization");
const manageAuthClose  = document.querySelector("#btnCloseManageAuthorization");
const manageAuthStatus = document.querySelector("#pManageAuthorizationResponse");

function initializeManageAuthorizations () {
 
    const addAuthBtn   = document.querySelector("#svgAddSignAuthorization");
    const submitButton = document.querySelector("#button_manage_Authorization");
    
    // add new Auth
    addAuthBtn.addEventListener("click", () => {
        manageAuthsModal.style.display = "block";

        manageAuthsModal.setAttribute("data-remove", false);

        submitButton.value = "Add Auth";
    });

    // try to remove existing Auth
    const rmvAuthBtn = document.querySelector("#svgRemoveSignAuthorization");

    rmvAuthBtn.addEventListener("click", () => {
        manageAuthsModal.style.display = "block";

        submitButton.value = "Remove Auth";

        manageAuthsModal.setAttribute("data-remove", true);
    });
}

manageAuthClose.addEventListener("click", () => {
    
    manageAuthsModal.style.display = "none";
    manageAuthStatus.style.display = "none";
    document.querySelector("#hManageAuth").innerHTML = "Remove Auth";

});

// close all pop-ups if user clicks outside of pop-up ui --------------------------------------

window.onmousedown = (event) => {

    if (event.target === addUsersModal) {

        addUsersModal.style.display = "none";
        addUsersModal.style.display = "none";
    }

    if (event.target === removeUsersModal) {

        removeUsersModal.style.display = "none";
        removeUsersModal.style.display = "none";
    }

    if (event.target === manageLocationsModal) {

        manageLocationsModal.style.display = "none";
        manageLocationStatus.style.display = "none";
    }

    if (event.target === manageAuthsModal) {

        manageAuthsModal.style.display = "none";
        manageAuthStatus.style.display = "none";
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