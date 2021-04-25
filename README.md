<p align="center">
	<br>
	<img src=".images/gitdomain_ico.png">
	<br>
	Discover endpoints using companies GitHub Repositories name 
</p>
<br>
<h2>Requirements</h2>
<p>
	<h4>HTTPX:</h4> Thanks to <a href="https://github.com/projectdiscovery">ProjectDiscovery</a> for such a great tool. You can download <b>httpx</b> from <a href="https://github.com/projectdiscovery/httpx">here</a>.
</p>
<br>
<h2>How it works:</h2>


	1. First it will get all repositories from ORG GitHub page.
	2. You can use a silgle domain or a list of subdomains.
	3. Then this tool will search for endpoints like:

		* reponame-sub.domain.com
		* reponame.domain.com
		* reponame.sub.domain.com
		* reponame-domain.com
		* reponamedomain.com
		* reponame.tld (Will add this in next release)
		* org.github.io/reponame

<p>
<h2>Usage</h2>
</p>

```
git clone https://github.com/pocdork/gitdomain.git
cd gitdomain

```
Save your GitHub access token in <code>.token</code> file (Only store one token without any space).
<p>
	<b>To use this with a single domain:</b>
</p>

```
bash gitdomain.sh [GutHub-ORG name] -d company.com
```

<p>
	<b>To use this with a list of subdomains:</b>
</p>

```
bash gitdomain.sh [GutHub-ORG name] -t domain.txt
```

<p>
	<h3>Demo:</h2>
	<a href="https://twitter.com/pocdork/status/1386059518119870465">https://twitter.com/pocdork/status/1386059518119870465</a>
	<br>
</p>
<p>
<h2>Follow Me</h2>
	
<a href="https://twitter.com/pocdork/"><img src=".images/twitter.svg" width="50" height="50"></a>
</p>
