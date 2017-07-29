#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'patriciasiqueira'
SITENAME = 'patriciasiqueira'
SITEURL = ''
PATH = 'content'
TIMEZONE = 'America/Sao_Paulo'
DEFAULT_LANG = 'pt'
DEFAULT_PAGINATION = False
DELETE_OUTPUT_DIRECTORY = True

THEME = './theme/'

STATIC_PATHS = ['images', 'extra', 'notebooks']
EXTRA_PATH_METADATA = {'extra/CNAME': {'path': 'CNAME'}, 'extra/README.md': {'path': 'README.md'} }
PAGE_PATHS = ['pages']
PAGE_URL = '{slug}.html'
PAGE_SAVE_AS = '{slug}.html'
INDEX_SAVE_AS = 'blog.html'
ARTICLE_PATHS = ['blog']

PLUGIN_PATHS = ['./plugins', './plugins/pelican-plugins']
PLUGINS = [
    # 'summary',       # auto-summarizing articles
    'ipynb.liquid',  # for embedding notebooks
    'liquid_tags.img',  # embedding images
    'liquid_tags.video',  # embedding videos
    'liquid_tags.include_code',  # including code blocks
    'liquid_tags.literal'
] # 'pelican_youtube', .. youtube:: VIDEO_ID

IGNORE_FILES = ['.ipynb_checkpoints']

# for liquid tags
CODE_DIR = 'code'
NOTEBOOK_DIR = 'notebooks'

FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None
