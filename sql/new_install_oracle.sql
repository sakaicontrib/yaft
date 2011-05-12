CREATE TABLE YAFT_FORUM (FORUM_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR2(99) NOT NULL
							,CREATOR_ID VARCHAR2(99) NOT NULL
							,TITLE VARCHAR2(255) NOT NULL
							,DESCRIPTION VARCHAR2(255)
							,DISCUSSION_COUNT NUMBER(10,0) NOT NULL
							,MESSAGE_COUNT NUMBER(10,0) NOT NULL
							,LAST_MESSAGE_DATE TIMESTAMP
							,START_DATE TIMESTAMP
							,END_DATE TIMESTAMP
							,LOCKED_FOR_WRITING char(1) NOT NULL
							,LOCKED_FOR_READING char(1) NOT NULL
							,STATUS VARCHAR2(36) NOT NULL
							,CONSTRAINT yaft_forum_pk PRIMARY KEY (FORUM_ID));
		
CREATE TABLE YAFT_FORUM_GROUP (FORUM_ID CHAR(36) NOT NULL
							,GROUP_ID VARCHAR2(36) NOT NULL
							,CONSTRAINT yaft_forum_group_pk PRIMARY KEY (FORUM_ID,GROUP_ID));

CREATE TABLE YAFT_FORUM_DISCUSSION (FORUM_ID CHAR(36) NOT NULL
							,DISCUSSION_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_forum_discussion_pk PRIMARY KEY (FORUM_ID,DISCUSSION_ID));

CREATE TABLE YAFT_DISCUSSION (DISCUSSION_ID CHAR(36) NOT NULL
							,LAST_MESSAGE_DATE TIMESTAMP NOT NULL
							,MESSAGE_COUNT NUMBER(10,0) NOT NULL
							,STATUS VARCHAR2(36) NOT NULL
							,START_DATE TIMESTAMP
							,END_DATE TIMESTAMP
							,LOCKED_FOR_WRITING char(1) NOT NULL
							,LOCKED_FOR_READING char(1) NOT NULL
							,GRADEBOOK_ASSIGNMENT_ID BIGNUMBER(10,0)(20)
							,CONSTRAINT yaft_discussion_pk PRIMARY KEY (DISCUSSION_ID));

CREATE TABLE YAFT_MESSAGE (MESSAGE_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR2(99) NOT NULL
							,PARENT_MESSAGE_ID CHAR(36)
							,DISCUSSION_ID CHAR(36)
							,SUBJECT VARCHAR2(255) NOT NULL
							,CONTENT CLOB NOT NULL
							,CREATOR_ID VARCHAR2(99) NOT NULL
							,CREATED_DATE TIMESTAMP NOT NULL
							,STATUS VARCHAR2(36)
							,CONSTRAINT yaft_message_pk PRIMARY KEY (MESSAGE_ID));

CREATE TABLE YAFT_MESSAGE_CHILDREN (MESSAGE_ID CHAR(36) NOT NULL
							,CHILD_MESSAGE_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_message_children_pk PRIMARY KEY (MESSAGE_ID,CHILD_MESSAGE_ID));

CREATE TABLE YAFT_DISCUSSION_UNSUBS (DISCUSSION_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR2(99) NOT NULL
							,CONSTRAINT yaft_discussion_unsubs_pk PRIMARY KEY (DISCUSSION_ID,USER_ID));

CREATE TABLE YAFT_FORUM_UNSUBS (FORUM_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR2(99) NOT NULL
							,CONSTRAINT yaft_forum_unsubs_pk PRIMARY KEY (FORUM_ID,USER_ID));

CREATE TABLE YAFT_READ_MESSAGES (USER_ID VARCHAR2(99) NOT NULL
							,MESSAGE_ID CHAR(36) NOT NULL
							,CONSTRAINT yaft_read_messages_pk PRIMARY KEY (USER_ID,MESSAGE_ID));

CREATE TABLE YAFT_MESSAGE_ATTACHMENTS (MESSAGE_ID CHAR(36) NOT NULL
							,RESOURCE_ID VARCHAR2(255) NOT NULL
							,CONSTRAINT yaft_message_attachments_pk PRIMARY KEY (MESSAGE_ID,RESOURCE_ID));

CREATE TABLE YAFT_FORUM_READ (FORUM_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR2(99) NOT NULL
							,NUMBER_READ NUMBER(10, 0) NOT NULL
							,CONSTRAINT yaft_forum_read_pk PRIMARY KEY (FORUM_ID,USER_ID));

CREATE TABLE YAFT_DISCUSSION_READ (DISCUSSION_ID CHAR(36) NOT NULL
							,USER_ID VARCHAR2(99) NOT NULL
							,NUMBER_READ NUMBER(10, 0) NOT NULL
							,CONSTRAINT yaft_discussion_read_pk PRIMARY KEY (DISCUSSION_ID,USER_ID));

CREATE TABLE YAFT_PREFERENCES (USER_ID VARCHAR2(99) NOT NULL
							,SITE_ID VARCHAR2(99) NOT NULL
							,EMAIL_ALERTS VARCHAR2(24) NOT NULL
							,VIEW_MODE VARCHAR2(16) NOT NULL
							,CONSTRAINT yaft_preferences_pk PRIMARY KEY (USER_ID,SITE_ID));
		
CREATE TABLE YAFT_ACTIVE_DISCUSSIONS (DISCUSSION_ID CHAR(36) NOT NULL
							,SITE_ID VARCHAR2(99) NOT NULL
							,SUBJECT VARCHAR2(255) NOT NULL
							,LAST_MESSAGE_DATE TIMESTAMP NOT NULL
							,LATEST_MESSAGE_SUBJECT VARCHAR2(255) NOT NULL);
