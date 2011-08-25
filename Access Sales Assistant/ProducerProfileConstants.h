//
//  ProducerProfileConstants.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Access_Sales_Assistant_ProducerProfileConstants_h
#define Access_Sales_Assistant_ProducerProfileConstants_h

#pragma mark - constants

#define PRODUCER_PROFILE_SECTIONS @"GENERAL",@"QUESTIONS",@"STATUS",@"RATER",@"COMPANY CONTACT INFO",@"HOURS OF OPERATION",@"ADDRESSES",@"CONTACTS",nil

#define GENERAL_HEIGHT 188.0
#define QUESTIONS_HEIGHT 44.0
#define STATUS_HEIGHT 110.0

#define VIEW_HIDDEN_FRAME CGRectMake(0.0, 20.0, 768.0, 1004.0)
#define VIEW_VISIBLE_FRAME CGRectMake(0.0, -239.0, 768.0, 1004.0)
#define PICKER_VISIBLE_FRAME	CGRectMake(0.0, 765.0, 768.0, 259.0)
#define PICKER_HIDDEN_FRAME		CGRectMake(0, 864.0, 768.0, 259.0)

#define VALID_EMAIL_ALERT       @"Not a valid email id"
#define VALID_PHONE_ALERT       @"Not a valid phone number"
#define VALID_ZIP_CODE_ALERT       @"Not a valid zip code"
#define VALID_WEB_ADDRESS       @"Invalid Web Address"

#define COMMISSION_ADDRESS 2
#define MAILING_ADDRESS 1
#define PHYSICAL_ADDRESS 3

#define PHONE_1 3
#define FAX 4
#define MAIN_EMAIL 3
#define CLAIMS_EMAIL 5
#define ACCOUNTING_EMAIL 2
#define CUSTOMER_SERVICE_EMAIL 4

#pragma mark - enums
enum producerProfileSectionIndex
{
    EGeneral = 0,
    EQuestions,
    EStatus,
    ERater,
    ECompanyContactInfo,
    EHoursOfOperation,
    EAddresses,
    EContacts,
    EAllSectionsCount
};

enum generalSectionTags
{
    EProducerCode = 1,
    EProducerName,
    ENumberOfLocation,
    EDateEstablished,
    ESubTerritory,
    EEnOExpiration,
    EIsAccessSign,
    ENoOfEmployees,
};

enum questionSectionTags
{
    EAnswer = 1
};

enum statusSectionTags
{
  EAppointedDate = 1,  
  EStatusName,
    EStatusDate,
    ESuspensionReason,
    EIsEligible,
    EInEligibleReason
};

enum raterSectionTags
{
    ERater1=1,
    ERater2
};

enum companyContactInfoSectionTags
{
    EPhone1 =1,
    EFax,
    EMainEmail,
    EClaimsEmail,
    EAccountingEmail,
    ECustomerServiceEmail,
    EWebsiteAddress
};

enum hoursOfOperationSectionTags
{
   EMondayStartHour = 1,
   EMondayEndHour,
    ETuesdayStartHour,
    ETuesdayEndHour,
    EWednesdayStartHour,
    EWednesdayEndHour,
    EThursdayStartHour,
    EThursdayEndHour,
    EFridayStartHour,
    EFridayEndHour,
    ESaturdayStartHour,
    ESaturdayEndHour,
    ESundayStartHour,
    ESundayEndHour
    
};
enum addressSectionTags
{
  EAddressStreet1=1,  
    EAddressStreet2,
    EAddressCity,
    EAddressState,
    EAddressZipCode
};

enum contactSectionTags
{
    EContactFirstName = 1,
    EContactLastName,
    EContactTitle,
    EContactMobilePhone,
    EContactFax,
    EContactEmailAddress,
    EContactSSN
};
#endif
