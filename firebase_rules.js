rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
    match /settings/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /media/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /history/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /community/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /devices/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /alerts/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    match /calerts/{document} {
        allow create: if true;
        allow read, update : if isSignedIn() && isDocOwner();
    }
    function isSignedIn() {
        return request.auth.uid != null;
    }
    function isDocOwner() {
        return request.auth.uid == resource.data.uid;
    }
  }
}