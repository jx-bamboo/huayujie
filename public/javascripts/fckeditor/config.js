/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	config.language = 'ja';
	// config.uiColor = '#AADC6E';
	config.toolbar='Define';//自定义工具栏 \
	config.toolbar_Define=[ 
    	[ 'Styles','Format','Font','FontSize' ] ,
    	[ 'TextColor','BGColor' ],
    	['Image','Embed','Flash','Attachment','Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
    ]; 
};
