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
                                                <h4 class="feature-title mt-24">Learn English
                                                <p class="text-sm mb-0">Estudos apontam que 79% dos Brasileiros tendem a depositar mais confiança em alguem ou uma instituição que preza pela dificuldade e pela multinacionalidade de seu negócio
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon03_svg} alt="Feature 03">
                                                <h4 class="feature-title mt-24">Amplie seu MarketShare
                                                <p class="text-sm mb-0">Conheça que você não precisa ter algo de qualidade para ganhar dinheiro, aumente seu Market Share com nossa incrível metodologia.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon04_svg} alt="Feature 04">
                                                <h4 class="feature-title mt-24">Soft Skills
                                                <p class="text-sm mb-0">Descubra que você não precisa saber absolutamente nada para se dar bem, esqueça as Hard Skills, o futuro é você dominar as Soft Skills.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon05_svg} alt="Feature 05">
                                                <h4 class="feature-title mt-24">Seja Ardil
                                                <p class="text-sm mb-0">Aprenda as mais variadas técnicas de manipulação do vernáculo para que qualquer obstáculo moral, seja apenas um mero óbice insignificante.
                                    <div class="feature text-center is-revealing">
                                        <div class="feature-inner">
                                            <div class="feature-icon">
                                                <img src=@{StaticR img_featureIcon06_svg} alt="Feature 06">
                                                <h4 class="feature-title mt-24">Machine Learning
                                                <p class="text-sm mb-0">A Tecnologia é incrível, tenha acesso em primeira mão das tendências de mercado para que você possa sempre ser o pioneiro no que o seu market niche demandar. aprenda agora sobre machine learning
                    <section class="pricing section">
                        <div class="container-sm">
                            <div class="pricing-inner section-inner">
                                <div class="pricing-header text-center">
                                    <h2 class="section-title mt-0">Lições para a Vida Toda
                                    <p class="section-paragraph mb-0">Esqueça tudo o que você ja viu até hoje, tenha acesso ao nosso conteudo e prepare-se para mudar vidas.
                            <div class="pricing-tables-wrap">
                                <div class="pricing-table">
                                    <div class="pricing-table-inner is-revealing">
                                        <div class="pricing-table-main">
                                            <div class="pricing-table-header pb-24">
                                                <div class="pricing-table-price">
                                                    <span class="pricing-table-price-currency h2">R$
                                                    <span class="pricing-table-price-amount h1">637
                                                    <span class="text-xs">/mês
                                            <div class="pricing-table-features-title text-xs pt-24 pb-24">Aproveite nosso pacote!
                                                <ul class="pricing-table-features list-reset text-xs">
                                                    <li>
                                                        <span>Mais de 450 horas de video aulas.
                                                    <li>
                                                        <span>Mestres Renomados no Mercado.
                                                    <li>
                                                        <span>ChatBot Coach Training Ⓡ incluso.<
                                                    <li>
                                                        <span>Palestas Secretas para Membros.
        
            <footer>
                <div id="48248-2">
                    <script src="//ads.themoneytizer.com/s/gen.js?type=2">
                    <script src="//ads.themoneytizer.com/s/requestform.js?siteId=48248&formatId=2">
        |]    