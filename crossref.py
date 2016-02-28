import json, urllib3

http = urllib3.PoolManager()

xref_api_url = 'http://api.crossref.org/'
works = 'works'
# More stuff for later...
# members = 'members'
# types = 'types'
# licenses = 'licenses'

doi_url = 'http://doi.org/'

def query_xref(q):
	r = http.request('GET', xref_api_url+q)
	if r.status == 200 and r.getheader('Content-Type').split(';')[0] == 'application/json':
		result = json.loads(r.data.decode('utf-8'))
		r.close()
		return result
	else:
		return None 

def query_doi2bib(doi):
	r = http.request('GET', doi_url+doi,headers={'Accept':'application/x-bibtex'})
	if r.status == 200:
		return r.data
	return None

def doi_lookup(title, result_limit=5):
	exploded = title.replace(' ', '+')
	return query_xref(works+"?query="+exploded+'&rows='+str(result_limit))

def title2bib(title):
	result = doi_lookup(title)
	if result:
		try:
			return query_doi2bib(result['message']['items'][0]['DOI'])
		except:
			return None
	return None
