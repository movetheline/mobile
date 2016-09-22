var app = {

    browserWindow: null,

    // Production settings
    DOMAIN_URL: 'https://apps.dashplatform.com/',
    BROWSER_OPTIONS: 'location=no,toolbar=no',

    // Test settings
    //DOMAIN_URL: 'http://192.168.0.22/',
    //BROWSER_OPTIONS: null,

    // These are never used to redirect the browser, only to detect if we're on the respective pages
    FACEBOOK_LOGIN_URL_FLAG: 'https://m.facebook.com/',

    lastURL: null, // Used for bouncing back after an external link has been accessed

    contacts: [],

    startApplication: function(){
        app.openNewDashWindow(app.DOMAIN_URL);
    },

    openNewDashWindow: function(url){
        app.browserWindow = window.open(url, '_blank', app.BROWSER_OPTIONS);
        app.fetchContacts();
        app.browserWindow.addEventListener('loadstart', app.onLoadStart, false);
        app.browserWindow.addEventListener('loadstop', app.onLoadStop, false);
        app.browserWindow.addEventListener('exit', function(){
            navigator.app.exitApp();
        }, false);
    },

    onLoadStart: function(event){

        // Android only
        if (navigator.notification.activityStart) {
            navigator.notification.activityStart("Loading", "Please Wait...");
        }

        app.browserWindow.executeScript({code: "window.dispatchEvent(new Event('mobileAppOnLoadStart'));"});
    },

    onLoadStop: function(event){

        // Android only
        if (navigator.notification.activityStop) {
            navigator.notification.activityStop();
        }

        if(!app.containsString(event.url, app.DOMAIN_URL) && !app.containsString(event.url, app.FACEBOOK_LOGIN_URL_FLAG)){
            app.openExternalBrowser(event.url);
            return;
        }
        app.lastURL = event.url; // Record the last URL in case we open an external URL and have to backup
        app.browserWindow.executeScript({code: "window.dispatchEvent(new Event('mobileAppOnLoadStop'));"});
        app.setContactsInPage();
    },

    fetchContacts: function() {

        // find all contacts with 'Bob' in any name field
        var options = new ContactFindOptions();
        options.filter = '';
        options.multiple = true;
        navigator.contacts.find(['*'], app.contactFetchSuccess, app.contactFetchFail, options);
    },

    // onSuccess: Get a snapshot of the current contacts
    contactFetchSuccess: function(contacts) {
        console.log(contacts);
        app.contacts = contacts;
        app.setContactsInPage();
    },

    contactFetchFail: function(contactError) {
        console.log(contactError);
        alert('onError!');
    },

    setContactsInPage: function() {
        app.browserWindow.executeScript({code: "sessionStorage.setItem('contacts', JSON.stringify(" + JSON.stringify(app.contacts) + "));"});
    },

    /**
     * Utility method for checking if a string contains a particular substring
     * @param haystack
     * @param needle
     * @returns {boolean}
     */
    containsString: function(haystack, needle){
        return (haystack.indexOf(needle) !== -1);
    },

    openExternalBrowser: function(url){
        window.open(url, '_system');
        app.openNewDashWindow(app.lastURL); // Reopen inAppBrowser on old URL
    }

};

app.startApplication();