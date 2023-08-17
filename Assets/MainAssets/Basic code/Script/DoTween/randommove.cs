﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class randommove : MonoBehaviour
{
    public float distance,RandomRate,needtime;
    private MainLine line;
    private Vector3 trans;
    private bool OK=false;
    // Start is called before the first frame update
    void Start()
    {
        trans=this.transform.position;
        line=GameObject.FindGameObjectWithTag("line").GetComponent<MainLine>();
        this.transform.Translate(producerandom()*RandomRate,producerandom()*RandomRate,producerandom()*RandomRate);
    }

    // Update is called once per frame
    void Update()
    {
        if(Vector3.Distance(this.transform.position,line.transform.position)<=distance&&!OK)
        {
            DOMoves();
        }
    }
    float producerandom()
    {
        float value;
        value=Random.value;
        if(Random.value>=0.5)
        value=-value;
        if(RandomRate*value<distance)
        return value;
        else return producerandom();
    }
    void DOMoves()
    {
        this.transform.DOMove(trans,needtime);
        OK=true;
    }
}
