{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")


getHomeR :: Handler Html
getHomeR = do 
    sess <- lookupSession "_NOME"
    defaultLayout $ do 
        -- addScriptRemote "url" -> CHAMA JS EXTERNO
        -- addScript (StaticR script_js), ONDE script 
        -- eh o nome do seu script.
        -- pasta css, arquivo: bootstrap.css
        addStylesheet (StaticR css_bootstrap_css)
        
        toWidgetHead [julius|
            function ola(){
                alert("ola");
            }
        |]
        [whamlet|
            <div id="48248-6">
              <script src="//ads.themoneytizer.com/s/gen.js?type=6">
              <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=6">
            <ul>
                <li>
                    <a href=@{AdminR}>
                        ADMINISTRADOR
                <li>
                    <a href=@{EntrarR}>
                        LOGIN DE USUARIO
                <li>
                    <a href=@{SairR}>
                        SAIR DA SESSAO
                        
            <div style="text-align:center;" id="48248-31">
                <script src="//ads.themoneytizer.com/s/gen.js?type=31">
                <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=31">
        
            <div class="body-wrap">
                <header class="site-header">
                    <div class="container">
                        <div class="site-header-inner">
                            <div class="brand header-brand">
                                <h1 class="m-0">
                                    <a href="#">
                                        <img class="header-logo-image" src=@{StaticR img_logo_svg} alt="Logo">
                                        
                <main>
                    <section class="hero">
                        <div class="container">
                            <div class="hero-inner">
                                <div class="hero-copy">
                                    <h1 class="hero-title mt-0">Seja o melhor COACH do país com nosso incrível curso EAD.
                                    <p class="hero-paragraph">Aprenda com os maiores pandilhas que já habitaram a face da terra.
                                    <div class="hero-cta">
                                        <a class="button button-primary" href="#">Conheça nosso Elenco
                                        <a class="button" href="#">Cases de Sucesso
                                        
                                <div class="hero-figure anime-element">
                                    <svg class="placeholder" width="528" height="396" viewBox="0 0 528 396">
                                        <rect width="528" height="396" style="fill:transparent;" />
                                    <div class="hero-figure-box hero-figure-box-01" data-rotation="45deg">
                                    <div class="hero-figure-box hero-figure-box-02" data-rotation="-45deg">
                                    <div class="hero-figure-box hero-figure-box-03" data-rotation="0deg">
                                    <div class="hero-figure-box hero-figure-box-04" data-rotation="-135deg">
                                    <div class="hero-figure-box hero-figure-box-05">
                                    <div class="hero-figure-box hero-figure-box-06">
                                    <div class="hero-figure-box hero-figure-box-07">
                                    <div class="hero-figure-box hero-figure-box-08" data-rotation="-22deg">
                                    <div class="hero-figure-box hero-figure-box-09" data-rotation="-52deg">
                                    <div class="hero-figure-box hero-figure-box-10" data-rotation="-50deg">
        
                    <section class="features section">
                        <div class="container">
                            <div class="features-inner section-inner has-bottom-divider">
                                <div class="features-wrap">
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon01_svg} alt="Feature 01">
                                                <h4 class="feature-title mt-24">Mude seu Mindset
                                                <p class="text-sm mb-0">Aprenda 1001 técnicas revolucionárias para transformar sua visão de mundo. "O que você precisa não é de faculdade ou diploma. Você precisa mudar o seu Mindset." - Murilo Coach
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon02_svg} alt="Feature 02">

        
            <footer>
                <div id="48248-2">
                    <script src="//ads.themoneytizer.com/s/gen.js?type=2">
                    <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=2">
        |]    