from datetime import datetime

from sources.util import engine

reg_person = engine['reg_person']
reg_financial_data = engine['reg_financial_data']
reg_financial_data_custom_source = engine['reg_financial_data_custom_source']
reg_financial_data_turnover = engine['reg_financial_data_turnover']
reg_representative = engine['reg_representative']
reg_organisation = engine['reg_organisation']
reg_action_field = engine['reg_action_field']
reg_interest = engine['reg_interest']
reg_country_of_member = engine['reg_country_of_member']


def dateconv(ds):
    return datetime.strptime(ds.split("+")[0], "%Y-%m-%dT%H:%M:%S.%f")

def shortdateconv(ds):
    return datetime.strptime(ds, "%Y-%m-%d+%H:%M")


def intconv(val):
    return val