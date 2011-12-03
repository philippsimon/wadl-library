<application xmlns="http://wadl.dev.java.net/2009/02"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xmlns:xsd="http://www.w3.org/2001/XMLSchema"
             xmlns:apigee="http://api.apigee.com/wadl/2010/07/"
             xsi:schemaLocation="http://wadl.dev.java.net/2009/02 http://apigee.com/schemas/wadl-schema.xsd http://api.apigee.com/wadl/2010/07/ http://apigee.com/schemas/apigee-wadl-extensions.xsd">

      <resources base="http://ws.spotify.com/">

        <!-- Lookup -->

        <resource path="lookup">
            <method id="Lookup" name="GET" apigee:displayName="Lookup">
                <apigee:tags>
                    <apigee:tag primary="true">Lookup</apigee:tag>
                </apigee:tags>

                <apigee:authentication required="http://developer.spotify.com/en/metadata-api/lookup/"/>

                <apigee:example url="lookup/1/.{format}?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ"/>

                <doc title="Lookup" apigee:url="http://developer.spotify.com/en/metadata-api/lookup/">
                  <![CDATA[Lookup data related to a Spotify URI.]]>
                </doc>

                <request>
                    <!-- Required parameters -->

                    <param name="format" type="xsd:string" style="template" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/lookup/">
                            <![CDATA[The format to be returned in the response. (e.g. JSON, or XML)]]>
                        </doc>
                    </param>

                    <param name="uri" type="xsd:string" style="query" required="true">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/lookup/">
                            <![CDATA[A Spotify URI. Either artist, album, or track.]]>
                        </doc>
                    </param>

                    <param name="extras" type="xsd:string" style="query" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/lookup/">
                            <![CDATA[A comma-separated list of words that defines the detail level expected in the response]]>
                        </doc>
                    </param>

                  
                </request>

                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
         </resource>

        <resource path="search">
            <method id="album" name="GET" apigee:displayName="Album">
                <apigee:tags>
                    <apigee:tag primary="true">Search</apigee:tag>
                </apigee:tags>

                <apigee:authentication required="http://developer.spotify.com/en/metadata-api/search/album/"/>

                <apigee:example url="search/1/album.{format}?q=foo"/>

                <doc title="Album" apigee:url="http://developer.spotify.com/en/metadata-api/search/album/">
                  <![CDATA[Search for Spotify metadata by album name.]]>
                </doc>

                <request>
                    <!-- Required parameters -->

                    <param name="format" type="xsd:string" style="template" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/album">
                            <![CDATA[The format to be returned in the response. (e.g. JSON, or XML)]]>
                        </doc>
                    </param>

                    <param name="q" type="xsd:string" style="query" required="true">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/album">
                            <![CDATA[Album search string encoded in UTF-8.]]>
                        </doc>
                    </param>

                    <param name="page" type="xsd:integer" style="query" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/album">
                            <![CDATA[The page of the result set to return; defaults to 1]]>
                        </doc>
                    </param>

                  
                </request>

                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>

            <method id="artist" name="GET" apigee:displayName="Artist">
                <apigee:tags>
                    <apigee:tag primary="true">Artist</apigee:tag>
                </apigee:tags>

                <apigee:authentication required="http://developer.spotify.com/en/metadata-api/search/artist/"/>

                <apigee:example url="search/1/artist.{format}?q=bar"/>

                <doc title="Artist" apigee:url="http://developer.spotify.com/en/metadata-api/search/artist/">
                  <![CDATA[Search for Spotify metadata by artist name.]]>
                </doc>

                <request>
                    <!-- Required parameters -->

                    <param name="format" type="xsd:string" style="template" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/artist/">
                            <![CDATA[The format to be returned in the response. (e.g. JSON, or XML)]]>
                        </doc>
                    </param>

                    <param name="q" type="xsd:string" style="query" required="true">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/artist">
                            <![CDATA[Artist search string encoded in UTF-8.]]>
                        </doc>
                    </param>

                    <param name="page" type="xsd:integer" style="query" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/artist">
                            <![CDATA[The page of the result set to return; defaults to 1]]>
                        </doc>
                    </param>
                  
                </request>

                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
 
            <method id="track" name="GET" apigee:displayName="Track">
                <apigee:tags>
                    <apigee:tag primary="true">Track</apigee:tag>
                </apigee:tags>

                <apigee:authentication required="http://developer.spotify.com/en/metadata-api/search/track/"/>

                <apigee:example url="search/1/track.{format}?q=bar"/>

                <doc title="Track" apigee:url="http://developer.spotify.com/en/metadata-api/search/track/">
                  <![CDATA[Search for Spotify metadata by track name.]]>
                </doc>

                <request>
                    <!-- Required parameters -->

                    <param name="format" type="xsd:string" style="template" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/track/">
                            <![CDATA[The format to be returned in the response. (e.g. JSON, or XML)]]>
                        </doc>
                    </param>

                    <param name="q" type="xsd:string" style="query" required="true">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/track">
                            <![CDATA[Track search string encoded in UTF-8.]]>
                        </doc>
                    </param>

                    <param name="page" type="xsd:integer" style="query" required="false">
                        <doc apigee:url="http://developer.spotify.com/en/metadata-api/search/track">
                            <![CDATA[The page of the result set to return; defaults to 1]]>
                        </doc>
                    </param>
                  
                </request>

                <response>
                    <representation mediaType="application/json"/>
                    <representation mediaType="application/xml"/>
                </response>
            </method>
 
 
         </resource>

   </resources>
</application>
