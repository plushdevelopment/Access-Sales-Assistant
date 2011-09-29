//
//  AccessSalesConstants.h
//  Access Sales Assistant
//
//  Created by Easwara Reddy Illuri on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef Access_Sales_Assistant_AccessSalesConstants_h
#define Access_Sales_Assistant_AccessSalesConstants_h

//Web request success/failure alert message
#define PRODUCER_PROFILE_REQUEST_SUCCESS @"Producer Profile Submitted Successfully\n\nUpdates to the following fields will not be reflected immediately:\n- Agency Name\n- Rater\n- Rater 2\n- Mailing Address\n- Commission Address\n- Physical Address\n- Contact SSN"
#define PRODUCER_PROFILE_REQUEST_FAILED @"Producer Profile Request Failed \n Error Description:%@"


#define PRODUCER_SUMMARY_REQUEST_SUCCESS @"Producer Summary Submitted Successfully"
#define PRODUCER_SUMMARY_REQUEST_FAILED @"Producer Summary Request Failed \n Error Description:%@"

#define LOGIN_REQUEST_SUCCESS @"Successfully logged in"
#define LOGIN_REQUEST_FAILED @"Login Failed"

#define POST_IMAGE_SUCCESS @"Successfully uploaded the picture"
#define POST_IMAGE_FAILED @"Failed to uploading pictures \n %@"

#define SEARCH_PRODUCER_FAILED @"Search producer failed \n %@"

//Main menu sections

//Section submenu titles
#define VISIT_APPLICATION_DAYS      @"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil
#define CONTACT_OPTIONS             @"Email Sales Compliance",@"Email Customer Service",@"Email Insufficient Funds",@"Email Product",@"Quality Assurance Form",@"Email Facilities",@"Quality Assurance Timetable",@"Email Help Desk",nil
#define SECTION_TITLES              @"Daily Schedule",@"Add New Prospect",@"Features & Benefits",@"Training",@"Email Atlanta",@"Get Directions",@"Search Producer",@"Total Access",nil

#define SOCIAL_MEDIA_OPTIONS @"Access.com",@"LinkedIn",@"Twitter",@"Facebook",@"Career Builder",nil
#define SOCIAL_MEDIA_IMAGE_NAME @"access_icon.png",@"linkedin_icon.png",@"twitter_icon.png",@"facebook_icon.png",@"career_builder_icon.png",nil
#define SOCIAL_MEDIA_URL @"http://www.access.com",@"http://www.linkedin.com/company/54125",@"http://www.twitter.com/AccessOnTheGo",@"http://www.facebook.com/AccessInsuranceCompany",@"http://www.accessgeneral.jobs",nil


//Section indexes
//Main menu
#define VISIT_APP_INDEX             0
#define PROSPECT_APP_INDEX          1
#define FEATURES_AND_BENEFITS_INDEX 2
#define ACCESS_ACADEMY_INDEX        3
#define CONTACTS_OPTIONS_INDEX      4
#define GPS_INDEX                   5
#define SEARCH_PRODUCER_INDEX       6
#define SOCIAL_MEDIA_INDEX          7
//Access Academy
#define FLASH_CARD_PROSPECT         1
#define FLASH_CARD_ZERO_PRODUCER    2
#define FLASH_CARD_PRODUCER         3
#define TRAINING_VIDEO              1
#define TRAINING_VIDEO_EXPANDED     4
//Contacts
#define CONTACT_QA_TABLE            6




#endif
