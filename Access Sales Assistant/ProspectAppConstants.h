//
//  ProspectAppConstants.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Access_Sales_Assistant_ProspectAppConstants_h
#define Access_Sales_Assistant_ProspectAppConstants_h

#pragma mark - constants

#define PROSPECT_APP_SECTIONS @"General",@"Addresses",@"Contact Info",@"Rater",@"Contacts",nil

#define GENERAL_HEIGHT      125.0
#define ADDRESS_HEIGHT      72.0
#define CONTACT_INFO_HEIGHT 120.0
#define RATER_HEIGHT        44.0
#define CONTACT_HEIGHT      130.0


#define VIEW_HIDDEN_FRAME       CGRectMake(0.0, 20.0, 768.0, 1004.0)
#define VIEW_VISIBLE_FRAME      CGRectMake(0.0, -239.0, 768.0, 1004.0)
#define PICKER_VISIBLE_FRAME	CGRectMake(0.0, 765.0, 768.0, 259.0)
#define PICKER_VISIBLE_FRAME_LANDSCAPE	CGRectMake(0.0, 509.0, 768.0, 259.0)
#define PICKER_HIDDEN_FRAME		CGRectMake(0, 864.0, 768.0, 259.0)
#define PICKER_HIDDEN_FRAME_LANDSCAPE		CGRectMake(0, 768.0, 768.0, 259.0)
#define VALID_EMAIL_ALERT       @"Not a valid email id"
#define VALID_PHONE_ALERT       @"Not a valid phone number"
#define VALID_ZIP_CODE_ALERT       @"Not a valid zip code"

#define PHONE_1 1

#pragma mark - enums

enum EProspectSectionIndex
{
    EGeneral=0,
    EAddresses,
    EContactInfo,
    ERater,
    EContact,
    EProspectNumSections
};
enum EProspectGeneralTags
{
    EProducerName =1,
    ETSMName,
    ESubTerritory,
    ESource
};
enum EProspectAddressesTags
{
    EAddressStreet1 = 1,
    EAddressStreet2,
    EAddressCity,
    EAddressState,
    EAddressZip
};
enum EProspectContactInfoTags
{
    EContactInfoPhone=1,
    EContactInfoFax,
    EContactInfoEmail
    
};
enum EProspectRaterTags
{
    ERater1=1,
    ERater2
};
enum EProspectContactTags
{
    EOwnerFirstName =1,
    EOwnerLastName,
    EPrimaryFirstName,
    EPrimaryLastName
};


#endif
