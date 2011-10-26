CREATE TABLE YAFT_FORUM (FORUM_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR(99) NOT NULL
							,CREATOR_ID VARCHAR(99) NOT NULL
							,TITLE VARCHAR(255) NOT NULL
							,DESCRIPTION VARCHAR(255)
							,DISCUSSION_COUNT INT NOT NULL
							,MESSAGE_COUNT INT NOT NULL
							,LAST_MESSAGE_DATE DATETIME
							,START_DATE DATETIME
							,END_DATE DATETIME
							,LOCKED_FOR_WRITING BOOL NOT NULL
							,LOCKED_FOR_READING BOOL NOT NULL
							,STATUS VARCHAR(36) NOT NULL
							,CONSTRAINT yaft_forum_pk PRIMARY KEY (FORUM_ID));
		
CREATE TABLE YAFT_FORUM_GROUP (FORUM_ID CHAR(36) NOT NULL
							,GROUP_ID VARCHAR(36) NOT NULL
							,CONSTRAINT yaft_forum_group_pk PRIMARY KEY (FORUM_ID,GROUP_ID));

CREATE TABLE YAFT_FORUM_DISCUSSION (FORUM_ID CHAR(36) NOT NULL
							,DISCUSSION_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_forum_discussion_pk PRIMARY KEY (FORUM_ID,DISCUSSION_ID));

CREATE TABLE YAFT_DISCUSSION (DISCUSSION_ID CHAR(36) NOT NULL
							,LAST_MESSAGE_DATE DATETIME NOT NULL
							,MESSAGE_COUNT INT NOT NULL
							,STATUS VARCHAR(36) NOT NULL
							,START_DATE DATETIME
							,END_DATE DATETIME
							,LOCKED_FOR_WRITING BOOL NOT NULL
							,LOCKED_FOR_READING BOOL NOT NULL
							,GRADEBOOK_ASSIGNMENT_ID BIGINT(20)
							,CONSTRAINT yaft_discussion_pk PRIMARY KEY (DISCUSSION_ID));

CREATE TABLE YAFT_MESSAGE (MESSAGE_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR(99) NOT NULL
							,PARENT_MESSAGE_ID CHAR(36)
							,DISCUSSION_ID CHAR(36)
							,SUBJECT VARCHAR(255) NOT NULL
							,CONTENT MEDIUMTEXT NOT NULL
							,CREATOR_ID VARCHAR(99) NOT NULL
							,CREATED_DATE DATETIME NOT NULL
							,STATUS VARCHAR(36)
							,CONSTRAINT yaft_message_pk PRIMARY KEY (MESSAGE_ID));

CREATE TABLE YAFT_MESSAGE_CHILDREN (MESSAGE_ID CHAR(36) NOT NULL
							,CHILD_MESSAGE_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_message_children_pk PRIMARY KEY (MESSAGE_ID,CHILD_MESSAGE_ID));

CREATE TABLE YAFT_DISCUSSION_UNSUBS (DISCUSSION_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR(99) NOT NULL
							,CONSTRAINT yaft_discussion_unsubs_pk PRIMARY KEY (DISCUSSION_ID,USER_ID));

CREATE TABLE YAFT_FORUM_UNSUBS (FORUM_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR(99) NOT NULL
							,CONSTRAINT yaft_forum_unsubs_pk PRIMARY KEY (FORUM_ID,USER_ID));

CREATE TABLE YAFT_READ_MESSAGES (USER_ID VARCHAR(99) NOT NULL
							,MESSAGE_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_read_messages_pk PRIMARY KEY (USER_ID,MESSAGE_ID));

CREATE TABLE YAFT_MESSAGE_ATTACHMENTS (MESSAGE_ID CHAR(36) NOT NULL
							,RESOURCE_ID VARCHAR(255) NOT NULL
							,CONSTRAINT yaft_message_attachments_pk PRIMARY KEY (MESSAGE_ID,RESOURCE_ID));

CREATE TABLE YAFT_FORUM_READ (FORUM_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR(99) NOT NULL
							,NUMBER_READ INT NOT NULL
							,CONSTRAINT yaft_forum_read_pk PRIMARY KEY (FORUM_ID,USER_ID));

CREATE TABLE YAFT_DISCUSSION_READ (DISCUSSION_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR(99) NOT NULL
							,NUMBER_READ INT NOT NULL
							,CONSTRAINT yaft_discussion_read_pk PRIMARY KEY (DISCUSSION_ID,USER_ID));

CREATE TABLE YAFT_PREFERENCES (USER_ID VARCHAR(99) NOT NULL
							,SITE_ID VARCHAR(99) NOT NULL
							,EMAIL_ALERTS VARCHAR(24) NOT NULL
							,VIEW_MODE VARCHAR(16) NOT NULL
							,CONSTRAINT yaft_preferences_pk PRIMARY KEY (USER_ID,SITE_ID));
		
CREATE TABLE YAFT_ACTIVE_DISCUSSIONS (DISCUSSION_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR(99) NOT NULL
							,SUBJECT VARCHAR(255) NOT NULL
							,LAST_MESSAGE_DATE DATETIME NOT NULL
							,LATEST_MESSAGE_SUBJECT VARCHAR(255) NOT NULL);
							
CREATE TABLE YAFT_DISCUSSION_GROUP (DISCUSSION_ID CHAR(36) NOT NULL
							,GROUP_ID VARCHAR(36) NOT NULL
							,CONSTRAINT yaft_discussion_group_pk PRIMARY KEY (DISCUSSION_ID,GROUP_ID));